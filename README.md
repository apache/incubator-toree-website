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

## Setup

1. Have docker installed
2. Have Make installed
3. run `make build`

## Running locally

```
make run
```

## Pushing to site

The first time you push the site you will need be asked for your ceredentials.

```
make deploy
```

Within a few minutes, svnpubsub should kick in and you'll be able to
see the results at
[toree.incubator.apache.org](http://toree.incubator.apache.org/).

## Adding contributors

To add a contributor to the project, or to modify existing contributors,
edit `_data/contributors.yml`.
The [project members]([http://localhost:4000/community.html#project-members]
list will re-generate.
