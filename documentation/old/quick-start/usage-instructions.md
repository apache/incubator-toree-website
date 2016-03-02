---
layout: docpage
title: Usage Instructions
type: doc
section: quick-start
weight: 0
tagline: Apache Project !
---


The Spark Kernel package contains an assembly jar and a startup script. The kernel can be started standalone or configured to be launched by a Jupyter notebook. Regardless of how you use the kernel, it is recommended to use the startup script.

#### Setting SPARK_HOME ####
After [building](Building-from-Source) the kernel, the startup script will be located at `<spark-kernel-project>/dist/spark-kernel/bin/spark-kernel`. This script requires a Spark distribution 1.5.x+ installed and set to `SPARK_HOME`. It uses `spark-submit` to start the kernel.

#### Setting SPARK_OPTS ####
Most options available for `spark-summit` apply to running the kernel. These options must be passed using the `SPARK_OPTS` env variable. 

Refer to the Spark [documentation](http://spark.apache.org/docs/latest/submitting-applications.html) for details on available options. Please note: the kernel is intended to be launched in `client-mode` since access to the kernel communication ports is essential (specially when launched through Jupyter)

#### Kernel Specific Options ####
The kernel also supports a series of options that are specific to the kernel. These options are passed directly to the startup script.

The following command line options are available:

* --profile <file> - the file to load containing the ZeroMQ port information
* --help - displays the help menu detailing usage instructions

Additionally, Network configurations can be passed as command line arguments

* --ip <address>
* --stdin-port <port>
* --shell-port <port>
* --iopub-port <port>
* --control-port <port>
* --heartbeat-port <port>

Ports can also be specified as Environment variables:

* IP
* STDIN_PORT
* SHELL_PORT
* IOPUB_PORT
* CONTROL_PORT
* HB_PORT

Other options

* --nosparkcontext  - The SparkContext is not created on startup.
