---
layout: docpage
title: Building from Source
type: doc
section: quick-start
weight: 0
tagline: Apache Project !
---

{% include JB/setup %}
The project uses `make` as the entry point to build and package the code. Under the hood, `make` is invoking `sbt` to compile, test, and build assemblies. It also sets certain key env variables. Additionally, it support running all `sbt` commands within a VM managed by [`Vagrant`](Vagrant-Development-Environment) to simplify development bootstrap. For these reasons, we do not recommend running `sbt` directly.

By default, `make` runs all commands directly on the host machine. This will require installation of `sbt`. You will need [sbt 0.13.7+](http://www.scala-sbt.org/download.html).

If you would like to rely on the `Vagrant` VM, then set environment variable `USE_VAGRANT=true` and then run `make` as usual. This will require [Vagrant](https://www.vagrantup.com) and a VM provider (like [VirtualBox](https://www.virtualbox.org/wiki/Downloads)).

### Compile Source ###

To build the code, use `make build`. This will compile and build the assembly jar. The `Makefile` specifies the default version of Spark to build against (env var `APACHE_SPARK_VERSION`). 

If you want to change the version of Apache Spark that the kernel is compiled against, specify the version via the `APACHE_SPARK_VERSION` environment variable.

    APACHE_SPARK_VERSION=1.5.2 make build

The recommended configuration options for sbt are as follows:

    -Xms1024M
    -Xmx2048M
    -Xss1M
    -XX:+CMSClassUnloadingEnabled
    -XX:MaxPermSize=1024M

### Packaging ###

To create a packaged up kernel, run `make dist`. This will create a package under `dist/`. It will include the kernel's assembly jar plus an executable that runs the kernel using `$SPARK_HOME/bin/spark-submit`
