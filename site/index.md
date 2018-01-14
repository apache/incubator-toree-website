---
layout: page
title: Home
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

## Apache Toree

Apache Toree is a kernel for the Jupyter Notebook platform providing interactively access to Apache Spark. It has been developed using the IPython protocol, and despite the protocol’s name, the apache Toree currently exposes the Spark programming model in Scala, Python and R languages.

Toree supports a number of types of interactions. In one common case, applications send snippets of code which are then executed by Spark, and the results are returned directly to the application. This style of interaction is what users of Notebooks experience when they evaluate code in cells. Instead of sending raw code, an application can send magics, which might be commands to add a JAR to the Spark execution context or a call to execute a shell command such as “ls”. Toree provides a well-defined mechanism to associate functionality with magics, and this is a useful point of extensibility of the system.

<img src='/assets/images/toree-basic-scenario.png' height="50%" width="50%">

Applications wanting to work with Spark can be located remotely from a Spark cluster and use a Apache Toree Client or Jupyter Client to communicate with a Apache Toree Server running on the cluster, or they can communicate directly with the Apache Toree Server. Multiple clients/applications can communicate with a single Kernel which contains a Spark application context, and this provides a simple form of multi-tenancy.

<img src='/assets/images/toree-application-scenario.png' height="50%" width="50%">
