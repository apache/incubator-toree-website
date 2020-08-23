---
layout: doc
title: How it works
type: doc
section: user
weight: 20
tagline: Apache Project !
---
<!--
{% comment %}
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to you under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
{% endcomment %}
-->

{% include JB/setup %}

# How it works

Toree provides an interactive programming interface to a Spark Cluster. It's API takes in `code` in a variety of 
languages and executes it. The `code` can perform Spark tasks using the provided Spark Context. 

To further understand how Toree works, it is worth exploring the role that it plays in several usage scenarios. 

### As a Kernel to Jupyter Notebooks

Toree's primary role is as a [Jupyter](http://jupyter.org/) Kernel. It was originally created to add full Spark API 
support to a Jupyter Notebook using the Scala language. It since has grown to also support Python an R. The diagram 
below shows Toree in relation to a running Jupyter Notebook.

![Toree with Jupyter Notebook](/assets/images/toree_with_notebook.png)

When the user creates a new Notebook and selects Toree, the Notebook server launches a new Toree process that is
configured to connect to a Spark cluster. Once in the Notebook, the user can interact with Spark by writing code that
uses the managed Spark Context instance.

The Notebook server and Toree communicate using the [Jupyter Kernel Protocol](https://ipython.org/ipython-doc/3/development/messaging.html). 
This is a [0MQ](http://zeromq.org/) based protocol that is language agnostic and allows for bidirectional communication
between the client and the kernel (i.e. Toree). This protocol is the __ONLY__ network interface for communicating with a 
Toree process. 

When using Toree within a Jupyter Notebook, these technical details can be ignored, but they are very relevant when 
building custom clients. Several options are discussed in the next section.

### As an Interactive Gateway to Spark

One way of using Spark is what is commonly referred to as 'Batch' mode. Very similar to other Big Data systems, such as 
Hadoop, this mode has the user create a program that is submitted to the cluster. This program runs tasks in the
cluster and ultimately writes data to some persistent store (i.e. HDFS or No-SQL store). Spark provided `Batch` mode
support through [Spark Submit](http://spark.apache.org/docs/latest/submitting-applications.html).

![Toree Gateway to Spark](/assets/images/batch_mode.png)

This mode of using Spark, although valid, suffers from lots of friction. For example, packaging and submitting of jobs, as
well as the reading and writing from storage, tend to introduce unwanted latencies. Spark alleviates some of the 
frictions by relying on memory to hold data along with the concept of a SparkContext as a way to tie jobs together. What
is missing from Spark is a way for applications to interact with a long living SparkContext. 

![Toree Gateway to Spark](/assets/images/interactive_mode.png)

Toree provides this through a communication channel between an application and a SparkContext that allows access to the 
entire Spark API. Through this channel, the application interacts with Spark by exchanging code and data.

The Jupyter Notebook is a good example of an application that relies on the presence of these interactive channels and
uses Toree to access Spark. Other Spark enabled applications can be built that directly connect to Toree through the 
`0MQ` protocol, but there are also other ways.

![Toree Gateway to Spark](/assets/images/toree_spark_gateway.png)

As shown above, the [Jupyter Kernel Gateway](https://github.com/jupyter/kernel_gateway) can be used to expose a Web 
Socket based protocol to Toree. This makes Toree easier to integrate. In combination with the
[jupyter-js-services](https://github.com/jupyter/jupyter-js-services) library, other web applications can access Spark
interactively. The [Jupyter Dashboard Server](https://github.com/jupyter-incubator/dashboards_server) is an example of
a web application that uses Toree as the backend to dynamic dashboards.

