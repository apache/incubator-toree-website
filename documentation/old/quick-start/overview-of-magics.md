---
layout: docpage
title: Overview of Magics
type: doc
section: quick-start
weight: 0
tagline: Apache Project !
---

The concept of magics stems from IPython, where various pieces of functionality
are provided through line and cell magics. Line magics are represented by a
single `%` followed by the magic name (e.g. `%AddJar <args>`) and only
allow for a single line of content. Cell magics are represented by `%%` followed by the magic name (e.g. `%%HTML <args>`) and allow for multiple
lines of content. See the examples below for more details.

#Line Magics

###Description
A line magic is basically a function that is supported by the kernel to expand its capabilities. Line magics are placed at the beginning of a line, prefixed by a `%` symbol, and receive the rest of the line as arguments:
```scala
// foo and bar will be arguments to ExampleLineMagic
%ExampleLineMagic foo bar
```

Multiple line magics can be invoked in a single cell:
```scala
val x = 3
%AddDeps com.google.guava guava 18.0
val z = 5
%lsmagic
import com.google.common.base.Strings._
```

### Other Things to Note
- Magic names are case insensitive; if a line magic `AddJar` exists, then `%addjar`, `%ADDJar`, and all other variants are valid. 

- Each magic has its own arguments; usage information can be obtained for a magic by typing `%<MagicName>`.

- Line magics receive the _literal_ rest of the line as arguments, so the following string interpolation will not work:
```scala
for(i <- (1 to 10)) 
  %addDeps s"com.google.guava guava $i"
```

# Cell Magics

### Description
Cell Magics are magics that take the rest of the cell as input. Unlike Line Magics, Cell Magics can alter the output of a cell and must be the first thing in the cell.

As an example, the `%%HTML` cell magic renders the contents of the cell as HTML:
```scala
%%HTML
<h1>Hello World!</h1>
// more arguments...
```

# Programmatic Magic Usage

### Description
There exists a programmatic API for those who do not wish to use the IPython-esque `%` and `%%` syntax. The Spark Kernel exposes a `kernel` object which provides programmatic invocation of magic code in the form:
```scala
//magicName is case insensitive
kernel.magics.<magicName>("<string of args>")
```
e.g.
```scala
// some line magics
kernel.magics.addJar("http://www.myjars.com/my.jar")
kernel.magics.addDeps("com.google.guava guava 18.0")
```

```scala
// a cell magic
kernel.magics.html("
  <h1>Hello World!</h1>
")
```

This syntax allows magics to be embedded in loops and other iteration, unlike the `%` equivalent:
```scala
(1 to 10).foreach (i => kernel.magics.addDeps(s"com.google.guava guava $i"))
```
