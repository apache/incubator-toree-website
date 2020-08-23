---
layout: doc
title: FAQ
type: doc
section: user
weight: 50
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

# FAQ

## How do I access Apache Spark?

You can access Spark through a `SparkContext` which is created by Apache Toree when the kernel starts. You can access
the context through the `sc` variable.

## How do I add a jar?
Jars are added through the `AddJar` magic. You simply need to supply an URL for the jar to be added.

```
%AddJar http://myproject.com/myproject/my.jar
```

For more information about the `AddJar` magic see the [Magic Tutorial Notebook][1].

## How do I add a library/dependency?

Dependencies stored in repositories can be added through the `AddDeps` magic. An example usage would be:

```
%AddDeps my.company artifact-id version
```

If the dependency you are trying to add has transitive dependencies, you can add the `--transitive` flag to add those dependencies as well.
For more information about the `AddDeps` magic see the [Magic Tutorial Notebook][1].

## How do I visualize data?
The most straightforward way to add data visualization with Apache Toree is through the [Jupyter Declarative Widgets][2] project.

## How do I create dashboards with interactive widgets?
Notebooks can be changed into dashboards through the [Jupyter Dashboards][3] project. This project allows you to use 
[Jupyter Declarative Widgets][2] in your dashboards.

[1]: https://github.com/apache/incubator-toree/blob/master/etc/examples/notebooks/magic-tutorial.ipynb
[2]: https://github.com/jupyter-incubator/declarativewidgets
[3]: https://github.com/jupyter-incubator/dashboards