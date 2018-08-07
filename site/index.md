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

Apache Toree is a kernel for the Jupyter Notebook platform providing interactive access to Apache Spark. It has been developed using the IPython messaging protocol and 0MQ, and despite the protocol’s name, the apache Toree currently exposes the Spark programming model in Scala, Python and R languages.

### Use Cases

Toree supports a number of interaction scenarios. In one common case, applications send snippets of code which are then executed by Spark, and the results are returned directly to the application. This style of interaction is what users of Notebooks experience when they evaluate code in cells. Instead of sending raw code, an application can send magics, which might be commands to add a JAR to the Spark execution context or a call to execute a shell command such as “ls”. Toree provides a well-defined mechanism to associate functionality with magics, and this is a useful point of extensibility of the system.

<div align="center">
  <img class="center-block" src="/assets/images/toree-scenario.png" height="75%" width="75%">
</div>

<br/>

Applications wanting to work with Spark can be located remotely from a Spark cluster and use a Apache Toree Client or Jupyter Client to communicate with a Apache Toree Server running on the cluster, or they can communicate directly with the Apache Toree Server. Multiple clients/applications can communicate with a single Kernel which contains a Spark application context, and this provides a simple form of multi-tenancy.


### Visualizations

Apache Toree, via extensions like [Brunel for Apache Toree](https://github.com/Brunel-Visualization/Brunel/tree/master/spark-kernel),
supports rich visualizations that integrates directly with Spark Data Frame APIs

<div align="center">
  <img src="/assets/images/toree-vizualization-brunel.png" height="75%" width="75%">
</div>

<br/>
<div align="center">
   <img src='http://blog.ibmjstart.net/wp-content/uploads/2016/07/vis-comparision1.png'>
</div>

<br/>


### Magics

Apache Toree provides a set of magics that enhances the user experience manipulating data coming from Spark tables or data


<div class="col-md-12">
    <div class="row">
        <div class="col-md-6">
         <img src="/assets/images/toree-magic-sql.png" height="100%" width="100%">
        </div>
        <div class="col-md-6">
          <img src="/assets/images/toree-magic-dataframe.png" height="100%" width="100%">
        </div>
    </div>
</div>
