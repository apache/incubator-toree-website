---
layout: docpage
title: Getting Started
type: doc
section: quick-start
weight: 0
tagline: Apache Project !
---

This short guide should serve to get you up and running with the _Spark Kernel_. [Click here](#getting-the-spark-kernel-running) to get the kernel up and running.

### What is the Spark Kernel? ###

The Spark Kernel is a Scala application that connects to an [Apache Spark][1] cluster. Rather than bundling the Apache Spark interface with your application and running it as an Apache Spark driver application, you can use the Spark Kernel as the proxy between your application(s) and the Apache Spark cluster.

Why would you want to do this?

1. Faster turnaround for your applications

    - The Spark Kernel compiles Scala code using the same compiler as the _Spark Shell_, meaning that your
      applications do not need to compile full jars to launch Spark tasks

2. Direct feedback to your applications

    - Rather than writing your data out to HDFS or another datastore and _immediately_ reading that data
      into your application, the Spark Kernel can feed results from Spark operations directly to your
      applications

3. Isolate Spark dependencies

    - Instead of including necessary Spark interfaces into each of your applications, you can use the
      Spark Kernel as the middleman for your applications

__For more information, please visit the [Spark Kernel Overview][2] and [In-depth Look at the Spark Kernel][3] sections.__

### Getting the Spark Kernel Running ###

##### Compiling and Packing the Kernel #####

As the Spark Kernel does not have a release pre-built, you will need to build it from source. This project use `make` as the entry point to dev/build. By default it does require `sbt`. More information [here](wiki/Building-from-Source). To build the kernel run:
```
make build
```
The should compile all modules of the Spark Kernel and generate an assembly jar under `kernel/target/scala-2.10`. After building you can do:
```
make dist
```
This generates a `dist` directory with the kernel library and executable. It also generates a tar package. Move this package anywhere visible by Jupyter to be able to run in a notebook.

##### Starting the Spark Kernel #####

If everything succeeded, you should now be able to launch the Spark Kernel by issuing the following:

    <spark-kernel-dist>/bin/spark-kernel

![](spark_kernel_running_output.png)

__To use different languages with the Spark Kernel, please visit [Language Support on the Spark Kernel][14].__

### Connecting to the Spark Kernel with Jupyter ###

We use Vagrant to simplify certain things. If you have Vagrant installed, the easiest way to test the kernel within Jupyter is to run
```
USE_VAGRANT=true make dev
```
This command will startup Jupyter (currently set to 3.2.1). The spark-kernel will be preconfigured and ready to use against a `local[2]` Spark cluster.

For detailed instructions about installing and using Jupyter, visit http://jupyter.org/.

The following are general instructions for installing a kernel on Jupyter. They may vary depending on your installation. The basic steps are:
 
1. `make dist` to bundle up the kernel
2. Create a kernel.json file for the Spark Kernel. It should look something like this:

    ```
    {
    "display_name": "Spark 1.5.1 (Scala 2.10.4)",
    "language_info": { "name": "scala" },
    "argv": [
        "/src/spark-kernel/dist/spark-kernel/bin/spark-kernel",
        "--profile",
        "{connection_file}"
    ],
    "codemirror_mode": "scala",
    "env": {
        "SPARK_OPTS": "--driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=trace",
        "MAX_INTERPRETER_THREADS": "16",
        "SPARK_CONFIGURATION": "spark.cores.max=4",
        "CAPTURE_STANDARD_OUT": "true",
        "CAPTURE_STANDARD_ERR": "true",
        "SEND_EMPTY_OUTPUT": "false",
        "SPARK_HOME": "/opt/spark",
        "PYTHONPATH": "/opt/spark/python:/opt/spark/python/lib/py4j-0.8.2.1-src.zip"
     }
   }
    ```
3. Place kernel.json in the correct location for your Jupyter installation. Typical location is `~/.ipython/kernels/spark/kernel.json`.

When you run Jupyter, you should now see a new option in the dropdown list.

![](ipython_dropdown_with_spark_kernel.png)

From here, you can now select the Spark Kernel, which will start a new Spark Kernel using Apache Spark local mode. 

For more details on configuring the kernel, see the [usage instructions][7].

### Connecting to the Spark Kernel with the Client Library ###

The current client library provides an abstraction toward communicating with the Spark Kernel. The library is currently designed for Scala-based applications.

As the client library does not have a release pre-built, you will need to build it from source. The client library uses _sbt_ as its build tool; so, you will need [sbt 0.13.5+][5] installed on your machine. From the root of the project, execute the following:

    sbt compile
    sbt publishLocal

You should now have published all public jars used by the client library.

The next step is to include the client project into your Scala application by adding the following to your _build.sbt_ file:

    libraryDependencies += "com.ibm.spark" %% "client" % "0.1.1-SNAPSHOT"

Finally, to instantiate a client instance within your Scala application and connect it to a running Spark Kernel, you should add the following to your application:

    val profileJSON: String = """
    {
        "stdin_port":   48691,
        "control_port": 40544,
        "hb_port":      43462,
        "shell_port":   44808,
        "iopub_port":   49691,
        "ip": "127.0.0.1",
        "transport": "tcp",
        "signature_scheme": "hmac-sha256",
        "key": ""
    }
    """.stripMargin

    // Parse our configuration and create a client connecting to our kernel
    val config: Config = ConfigFactory.parseString(profileJSON)
    val client = new SparkKernelClientBootstrap(config).createClient

Currently, the client only accepts input via a JSON string (or other manners of [TypeSafe Config][11] generation). Once executed, you should now have an instance of a client with which to communicate with the Spark Kernel. 

__For more information, please visit the [Guide to using the Spark Kernel Client][12] and [Guide to the Comm API][13] sections.__

[1]: https://spark.apache.org
[2]: Overview-of-the-Spark-Kernel-Project
[3]: In-depth-Look-at-the-Spark-Kernel
[4]: http://zeromq.org/
[5]: http://www.scala-sbt.org/download.html
[6]: Building-from-Source
[7]: Usage-Instructions-for-the-Spark-Kernel
[8]: Using-the-Docker-Container-for-the-Spark-Kernel
[9]: Vagrant-Development-Environment
[10]: Guide-to-Integrating-the-Spark-Kernel-with-the-IPython-Notebook-(3.x)
[11]: https://github.com/typesafehub/config
[12]: Guide-for-the-Spark-Kernel-Client
[13]: Guide-to-the-Comm-API-of-the-Spark-Kernel-and-Spark-Kernel-Client
[14]: Language-Support-on-the-Spark-Kernel
