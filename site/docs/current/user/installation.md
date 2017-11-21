---
layout: doc
title: Installation
type: doc
section: user
weight: 10
tagline: Apache Project !
---

{% include JB/setup %}

# Installation

## Setup

An Apache Spark distribution is required to be installed before installing Apache Toree. You can download a copy of Apache Spark [here](http://spark.apache.org/downloads.html). Throughout the rest of this guide we will assume you have downloaded and extracted the Apache Spark distribution to `/usr/local/bin/apache-spark/`.

## Installing Toree via Pip

The quickest way to install Apache Toree is through the toree pip package.

```
pip install toree
```

This will install a jupyter application called `toree`, which can be used to install and configure different Apache Toree kernels.

```
jupyter toree install --spark_home=/usr/local/bin/apache-spark/
```

You can confirm the installation by verifying the `apache_toree_scala` kernel is listed in the following command:

```
jupyter kernelspec list
```

## Options
Arguments that take values are actually convenience aliases to full
Configurables, whose aliases are listed on the help line. For more information
on full configurables, see '--help-all'.

```
--user
    Install to the per-user kernel registry
--debug
    set log level to logging.DEBUG (maximize logging output)
--replace
    Replace any existing kernel spec with this name.
--sys-prefix
    Install to Python's sys.prefix. Useful in conda/virtual environments.
--interpreters=<Unicode> (ToreeInstall.interpreters)
    Default: 'Scala'
    A comma separated list of the interpreters to install. The names of the
    interpreters are case sensitive.
--toree_opts=<Unicode> (ToreeInstall.toree_opts)
    Default: ''
    Specify command line arguments for Apache Toree.
--python_exec=<Unicode> (ToreeInstall.python_exec)
    Default: 'python'
    Specify the python executable. Defaults to "python"
--kernel_name=<Unicode> (ToreeInstall.kernel_name)
    Default: 'Apache Toree'
    Install the kernel spec with this name. This is also used as the base of the
    display name in jupyter.
--log-level=<Enum> (Application.log_level)
    Default: 30
    Choices: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
    Set the log level by value or name.
--config=<Unicode> (JupyterApp.config_file)
    Default: ''
    Full path of a config file.
--spark_home=<Unicode> (ToreeInstall.spark_home)
    Default: '/usr/local/spark'
    Specify where the spark files can be found.
--spark_opts=<Unicode> (ToreeInstall.spark_opts)
    Default: ''
    Specify command line arguments to proxy for spark config.
```

# Configuring Spark

Toree is started using the `spark-submit` script. All configuration options from Spark are consistent with configuring
a [Spark Submit](http://spark.apache.org/docs/latest/submitting-applications.html) job. There are two ways of
setting configuration options for Spark.

The first is at install time with the `--spark_opts` command line option.

```
jupyter toree instal --spark_opts='--master=local[4]'
```

The second option is configured at run time through the `SPARK_OPTS` environment variable.

```
SPARK_OPTS='--master=local[4]' jupyter notebook
```

__Note:__ There is an order of precedence to the configuration options. `SPARK_OPTS` will overwrite any values configured in `--spark_opts`.


# Configuring Toree

There are some configuration options that are specific to Toree.

```
Option                                             Description
------                                             -----------
--default-interpreter                              default interpreter for the kernel
--default-repositories                             comma separated list of additional
                                                     repositories to resolve
--default-repository-credentials                   comma separated list of credential
                                                     files to use
-h, --help                                         display help information
--interpreter-plugin
--ip                                               used to bind sockets
--jar-dir                                          directory where user added jars are
                                                     stored (MUST EXIST)
--magic-url                                        path to a magic jar
--max-interpreter-threads <Integer>                total number of worker threads to use
                                                     to execute code
--spark-context-initialization-timeout <Long>      number of milliseconds allowed for
                                                     creation of the spark context; default
                                                     is 100 milliseconds
--nosparkcontext                                   kernel should not create a spark
                                                     context
-v, --version                                      display version information
```

There are two way of setting these configuration options.

The first is at install time with the `--toree_opts` command line option.

```
jupyter toree instal --toree_opts='--nosparkcontext'
```

The second option is configured at run time through the `TOREE_OPTS` environment variable.

```
TOREE_OPTS='--nosparkcontext' jupyter notebook
```

__Note:__ There is an order of precedence to the configuration options. `TOREE_OPTS` will overwrite any values configured in `--toree_opts`.


## Installing Multiple Kernels

Apache Toree provides support for multiple languages. To enable this you need to install the configurations for these
interpreters as a comma seperated list to the `--interpreters` flag:

```
jupyter toree install --interpreters=Scala,PySpark,SparkR,SQL
```

The available interpreters and their supported languages are:

| Language | Spark Implementation | Value to provide to Apache Toree |
|----------|----------------------|----------------------------------|
| Scala    | Scala with Spark     | Scala                            |
| Python   | Python with PySpark  | PySpark                          |
| R        | R with SparkR        | SparkR                           |
| SQL      | Spark SQL            | SQL                              |

### Interpreter Requirements
* R version 3.2+
* Make sure that the packages directory used by R when installing packages is writable, necessary to installed modified SparkR library. This is done automatically before any R code is run.

If the package directory is not writable by the Apache Toree, then you should see an error similar to the following:

```
Installing package into ‘/usr/local/lib/R/site-library’
(as ‘lib’ is unspecified)
Warning in install.packages("sparkr_bundle.tar.gz", repos = NULL, type = "source") :
'lib = "/usr/local/lib/R/site-library"' is not writable
Error in install.packages("sparkr_bundle.tar.gz", repos = NULL, type = "source") :
unable to install packages
Execution halted
```
