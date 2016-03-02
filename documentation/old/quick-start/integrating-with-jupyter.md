---
layout: docpage
title: Integrating with Jupyter
type: doc
section: quick-start
weight: 0
tagline: Apache Project !
---

The following guide will explain packaging the Spark Kernel for use with the IPython notebook along with configuring the IPython notebook to provide the Spark Kernel as an option (next to python).

### Requirements ###

Packaged up kernel by running `make dist`. More detailed information [here](Building-from-Source#packaging). The resulting package will be under `dist/spark-kernel`. From now on, we will refer to this location as `<spark-kernel>`

### Configuring Jupyter ###

Kernels are registered into Jupyter by using a `kernel.json` file that describes how to launch the kernel process. This file is known as the Kernel Spec. Depending on the version of Jupyter/IPython ad your OS, the location of where to create this file varies. Please refer to [Jupyter 4](http://jupyter-client.readthedocs.org/en/latest/kernels.html#kernel-specs)/[IPython 3.2](https://ipython.readthedocs.org/en/3.x/development/kernels.html?highlight=kernel#kernel-specs) documentation for full instructions. We will refer to this location as `<kernel_config_dir>`.

Create `<kernel_config_dir>`/spark/kernel.json`. Add the following content:

```
{
    "display_name": "Spark 1.5.1 (Scala 2.10.4)",
    "language_info": { "name": "scala" },
    "argv": [
        "<spark-kernel>/bin/spark-kernel",
        "--profile",
        "{connection_file}"
    ],
    "codemirror_mode": "scala",
    "env": {
        "SPARK_OPTS": "--master=local[2] --driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info",
        "MAX_INTERPRETER_THREADS": "16",
        "CAPTURE_STANDARD_OUT": "true",
        "CAPTURE_STANDARD_ERR": "true",
        "SEND_EMPTY_OUTPUT": "false",
        "SPARK_HOME": "<SPARK_HOME>",
        "PYTHONPATH": "<SPARK_HOME>/python:<SPARK_HOME>/python/lib/py4j-0.8.2.1-src.zip"
     }
}
```

The _display name_ property is merely used in the dropdown menu of the
notebook interface.

The _argv_ property is the most significant part of the configuration as it
tells Jupyter what process to start as a kernel and provides it with the
port information Jupyter specifies for communication, as well as any other kernel specific options (see [details](Usage-Instructions-for-the-Spark-Kernel#kernel-specific-options)).



The _connection file_ is replaced by Jupyter with the path to the JSON file
containing port and signature information. That structure looks like the
following:

```
{
    "stdin_port": 48691,
    "ip": "127.0.0.1",
    "control_port": 44808,
    "hb_port": 49691,
    "signature_scheme": "hmac-sha256",
    "key": "",
    "shell_port": 40544,
    "transport": "tcp",
    "iopub_port": 43462
}
```

[CodeMirror](http://codemirror.net/) is used by Jupyter for cell editing and
syntax highlighting. It provides quite a few capabilities such as running cells
in _vim_. The field is optional in the above and can be set to a series of keys
and values, although a single value also works.

The _env_ property is used to define environment variables. The 2 most important variables to set are `SPARK_HOME` and `SPARK_OPTS` for spark specific options (see [details](Usage-Instructions-for-the-Spark-Kernel#setting-spark_opts)).

### Ensure that your kernel is available ###

The following commands are specific to IPython 3.2. You can test that your kernel is recognized by running the following:

1. `ipython kernelspec list` - shows a list of kernels, _spark_ should be there

2. `ipython console --kernel spark` - should launch the Spark Kernel and
    provide a console-like input

3. `ipython notebook` - open a notebook from the user interface, there should
    now be a dropdown menu (set to Python 2) in the top-right of the page that
    has an option for the Spark Kernel
