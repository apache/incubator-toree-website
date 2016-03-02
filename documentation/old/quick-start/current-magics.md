---
layout: docpage
title: Current Magics
type: doc
section: quick-start
weight: 0
tagline: Apache Project !
---

Magic names are case insensitive, so _AddJar_ is the same as _addjar_.

## Line Magics

* **AddDeps** _<my.company> <artifact-id> <version> [--transitive]_

    * Adds the specified dependencies from Maven Central to the Spark Kernel
      and Spark cluster

    * Requires the company name, artifact id, and version of the dependency

    * Including _--transitive_ will include all needed dependencies

    * Examples:
        * Adding a single library with all of its dependencies
            ```scala           
            %AddDeps org.apache.spark spark-streaming-kafka_2.10 1.1.0 --transitive
            ```

        * Using the programmatic API
            ```scala           
            kernel.magics.addDeps("org.apache.spark spark-streaming-kafka_2.10 1.1.0 --transitive")
            ```
* **AddJar** _<jar-path> [-f]_

    * Adds the specified jars to the Spark Kernel and Spark cluster

    * Requires the path to the jar, which can either be a local path or remote
      jar hosted via HTTP

    * Including _-f_ will ignore any cached jars and redownload remote
      jars

    * Examples:

        * Adding a single jar from HTTP and forcing redownload if cached
            ```scala 
            %AddJar http://example.com/some_lib.jar -f
            ```

        * Adding a single jar from the file system relative to the kernel
            ```scala 
            %AddJar file:/path/to/some/lib.jar
            ```

        * Using the programmatic API
            ```scala            
            kernel.magics.addJar("http://example.com/some_lib.jar -f")
            ```

* **LSMagic**

    * Lists all available magics in the kernel

    * Examples:

        * Percent syntax
            ```scala 
            %LSMagic
            ```

        * Using the programmatic API
            ```scala 
            kernel.magics.lsMagic()
            ```

## Cell Magics

* **Html** _<html-code>_

    * Returns the given code with a HTML MIME-type.

    * Examples:

        * Percent syntax
            ```scala 
            %%Html
            <h1>Hello</h1>
            <p>World</p>
            ```

        * Using the programmatic API
            ```scala 
            kernel.magics.html("<h1>Hello</h1><p>World</p>")
            ```

* **JavaScript** _<javascript-code>_

    * Returns the given code with an `application/javascript` MIME-type.

    * Examples:

        * Percent syntax
            ```scala 
            %%JavaScript
            var x = 3
            var y = x + 2
            ```

        * Using the programmatic API
            ```scala 
            kernel.magics.javascript("var x = 3; var y = x + 2")
            ```
