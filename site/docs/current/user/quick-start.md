---
layout: doc
title: Quick Start
type: doc
section: user
weight: 0
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

# Quick Start

## What is Apache Toree
Apache Toree has one main goal: provide the foundation for interactive applications to connect and use [Apache Spark][1].

The project intends to provide applications with the ability to send both packaged jars and code snippets. As it
implements the latest Jupyter message protocol, Apache Toree can easily plug into the Jupyter ecosystem for quick, interactive data exploration.

## Installing as kernel in Jupyter

This requires you to have a distribution of [Apache Spark][1] downloaded to the system where Apache Toree will run. The
following commands will install Apache Toree.

```
pip install --upgrade toree
jupyter toree install --spark_home=/usr/local/bin/apache-spark/
```

## Your Hello World example

One of the most common ways to use Apache Toree is for interactive data exploration in a Jupyter Notebook. You will
first need to install the notebook and get the notebook server running:

```
pip install notebook
jupyter notebook
```

The following clip shows a simple notebook running Scala code to print `Hello, World!`. Each of the code cells can be
run by pressing `Shift-Enter` on your keyboard.

<img src="/assets/images/toree-quick-start-notebook.gif" alt="Drawing" style="width: 100%;"/>

A key component to Apache Toree is that is will automatically create a `SparkContext` binding for you. This can be accessed
through the variable `sc`. The following clip shows code accessing the `SparkContext` and returning a value.

<img src="/assets/images/toree-quick-start-spark.gif" alt="Drawing" style="width: 100%;"/>


## Where to try Apache Toree?
* [![Binder](http://mybinder.org/badge.svg)][2]
* [Try Jupyter][3] (_Spark With Scala Notbeook_)
* [IBM Bluemix][4]



[1]: https://spark.apache.org/
[2]: http://mybinder.org/badge.svg)](http://mybinder.org/repo/apache/incubator-toree
[3]: http://try.jupyter.org
[4]: https://console.ng.bluemix.net/catalog/services/apache-spark
