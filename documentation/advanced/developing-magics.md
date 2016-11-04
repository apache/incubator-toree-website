---
layout: docpage
title: Developing Magics
type: doc
section: quick-start
weight: 0
tagline: Apache Project !
---

Apache Toree provides a pluggable interface for magics that allows
developers to write their own magics. This guide will focus on the technical details of implementing your own magics; for an introduction and conceptual overview of magics, see [Overview of Magics for Toree](overview-of-magics).

In this guide we'll look at the dependencies required to develop a magic, walk through creating a line magic and a cell magic, and discuss some useful magic features.

### Dependencies ###

In order to write a magic, you need to add the _kernel-api_ and _protocol_
modules of Apache Toree to your project.

In _sbt_, you can add the following lines:

    libraryDependencies ++= Seq(
        "org.apache.toree" %% "kernel-api" % "0.1.0,
        "org.apache.toree" %% "protocol" % "0.1.0"
    )

As the modules are not hosted on any repository, you will also need to build
and publish them locally. From the root of Apache Toree, you can execute
the following to compile and make available the Apache Toree modules:

    sbt compile && sbt publishLocal

## Developing Magics

A magic is implemented by extending either the ```LineMagic``` or ```CellMagic``` trait provided by Apache Toree. Each trait consists of a single function, ```execute```, that defines the magic's functionality.

### Developing a Line Magic ###

A line magic receives a line of code as input and performs an operation. To create a line magic, we extend the `LineMagic` trait, and override its `execute` method:

```scala
    class HelloLineMagic extends LineMagic {
        override def execute(code: String): LineMagicOutput = {
          // do stuff
        }
    }
```

Note that line magics aren't meant to return values; their return type ```LineMagicOutput``` is equivalent to ```Unit```.

#### Using the Magic
Now we can use our magic with either:
```scala
%helloLineMagic foo bar
```
or
```scala
kernel.magics.helloLineMagic("foo bar")
```

Behind the scenes, the ```execute``` method of ```HelloLineMagic``` gets called with ```"foo bar"``` as input.

### Developing a Cell Magic ###
A cell magic receives an entire cell of code as input and returns a mapping of MIME types to data. This mapping, defined by the type ```CellMagicOutput```, can be used to distinguish different data types produced by the magic. In an IPython setting, the ```CellMagicOutput``` mapping will influence the way a cell is rendered.

#### An HTML Cell Magic ###
As a concrete example, we'll develop an ```HTML``` cell magic that causes a cell to render its contents as HTML.

To create a cell magic, we extend the `CellMagic` trait, and override its `execute` method:

```scala
    class Html extends CellMagic {
        override def execute(code: String): CellMagicOutput = {
          // TODO
        }
    }
```

In this case, we want to package the code that the magic receives as HTML. To do so, we return a ```CellMagicOutput``` that maps ```MIMEType.TextHtml``` to the code received:

```scala
    class Html extends CellMagic {
        override def execute(code: String): CellMagicOutput = {
          CellMagicOutput(MIMEType.TextHtml -> code)
        }
    }
```

#### Using the Magic
We can use the magic with either:
```scala
%%HTML
<h1>a title</h1>
<p>some more HTML</p>
```
or
```scala
kernel.magics.html("<h1>a title</h1><p>some more HTML</p>")
```

Behind the scenes, the ```execute``` method of ```Html``` gets called with ```"<h1>a title</h1><p>some more HTML</p>"``` as input.

In an IPython setting, the ```CellMagicOutput``` mapping that our magic returns will cause the cell to be rendered as HTML:


![htmlexample](https://raw.githubusercontent.com/wiki/ibm-et/spark-kernel/magics_html_example.png)


Making `Magic` has never been this easy!


### Argument Parsing

Sometimes, it's useful to view the code received by the magic as a string of arguments. To help with parsing arguments out of the raw code string, you can include the `ArgumentParsingSupport` trait into your magic definition:

```scala
class HelloParsing extends LineMagic with ArgumentParsingSupport {
   val flag = parser.accepts("flag", "a boolean flag")
                    .withOptionalArg()
                    .ofType(classOf[Boolean])
                    .defaultsTo(true)

   override def execute(code: String): LineMagicOutput = {
      val args = parseArgs(code)
      if (args(0)) // do something
      else         // do something else
   }
}
```
### Adding Dependencies to Magics ###

For more practical uses of magics, there are various dependencies that need to
be brought in when the magic is executed. To facilitate dependency injection,
you add the desired dependency as an additional trait to the magic.

Currently, there are four available dependencies:

1. SparkContext - use the trait _IncludeSparkContext_ to bring in the context
   used by the kernel. This exposes the _sparkContext_ variable into the magic.

2. Interpreter - use the trait _IncludeInterpreter_ to bring in the interpreter
   used by the kernel. This exposes the _interpreter_ variable into the magic.

3. OutputStream - use the trait _IncludeOutputStream_ to bring in an output
   stream that directs output back to the client of the kernel (useful for
   streaming status updates). This exposes the _outputStream_ variable into
   the magic.

4. DependencyDownloader - use the trait _IncludeDependencyDownloader_ to bring
   in the tool used to support the _%AddDeps_ magic. This exposes the
   _dependencyDownloader_ variable into the magic.

As dependencies are injected, there is no guarantee that referencing a
dependency outside of a method will work. Instead, mark referencing code as
either _lazy_ or as a helper method.

```scala
    class HelloWorld extends LineMagic with IncludeOutputStream {
        val printStream = new PrintStream(outputStream)

        // ...
    }
```
should become

```scala
    class HelloWorld extends LineMagic with IncludeOutputStream {
        lazy val printStream = new PrintStream(outputStream)

        // ...
    }
```

### Adding an external magic to Apache Toree ###
In order to use an external magic we first need a `.jar` containing a magic in the `org.apache.toree.magic.builtin` package. Assuming we have such a `.jar` at location `/src/path/to/my/exampleMagic.jar` the `kernel.json` file needs to be changed to supply the path to the external magic. The command-line argument we need to add is `--magic-url` which takes a string:

```json
{
    "display_name": "Spark 1.2.1 (Scala 2.10.4)",
    "language_info": "scala",
    "argv": [
        "/home/vagrant/local/bin/sparkkernel",
        "--profile",
        "{connection_file}",
        "--magic-url",
        "/src/path/to/my/exampleMagic.jar"
    ],
    "codemirror_mode": "scala"
}
```

Then on start-up, the kernel will load the magic from that location and it can be used:
![example external magic](https://raw.githubusercontent.com/wiki/ibm-et/spark-kernel/external_magic_example.png)
### Examples ###

For some example implementations, check out the ```com.ibm.spark.magic.builtin``` package in the ```kernel``` project folder.

### Other Notes ###

There is a limitation with the current magic implementation that will force magic invocations to be case sensitive unless defined in the package _org.apache.toree.magic.builtin_.
