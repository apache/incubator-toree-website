---
layout: page
title: Apache Toree - Gateway to Apache Spark
type: Home
tagline: Apache Project !
---

{% include JB/setup %}

## Apache Toree


### How to enable an interactive application against Apache Spark?

There are several options to communicate with a Spark cluster, but none
provided the necessary flexibility combined with a API that would work for
them.

### The solution?

Apache Toree acts as the middleman between the application and a Spark
cluster.

### What is Apache Toree ?

Apache Toree was designed in response to our needs to enable applications
that are both interactive and remote to work with Apache Spark. When we
first started connecting applications to Spark, we discovered the existing
interaction mechanisms had serious limitations, such as requiring code to be
bundled in a JAR and writing results out to an external datastore.

To overcome these limitations, we wrote the Apache Toree that uses the
IPython protocol. Despite the protocol’s name, the apache Toree is not
limited to supporting just Python, and indeed our first application was
a Notebook for analyzing data with Scala.

Toree supports a number of types of interactions. In one common case,
applications send snippets of code which are then executed by Spark, and the
results are returned directly to the application. This style of interaction
is what users of Notebooks experience when they evaluate code in cells.
Instead of sending raw code, an application can send magics, which might be
commands to add a JAR to the Spark execution context or a call to execute a
shell command such as “ls”. Toree provides a well-defined mechanism to
associate functionality with magics, and this is a useful point of
extensibility of the system. The Kernel also supports an RPC-like interaction
for applications to communicate with Spark. This is supported through the
“Comm API” which is useful, for example, when an application needs to
repetitively apply the same function to different data values.

Applications wanting to work with Spark can be located remotely from a Spark
cluster and use a Apache Toree Client to communicate with a Apache Toree
Server running on the cluster, or they can communicate directly with the
Apache Toree Server. Multiple clients/applications can communicate with a
single Kernel which contains a Spark application context, and this provides
a simple form of multi-tenancy.

