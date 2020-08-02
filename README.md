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

# Apache Toree Website

This project is used to generate the [Apache Toree](https://toree.apache.org) website
and is based on the [Apache Website Template](https://github.com/apache/apache-website-template)

This template was generated using [Jekyll](https://jekyllrb.com/) 2.4.0.

To use it, copy the `site` directory into your project.  You must also
include licensing information from the `LICENSE` and `NOTICE` files in
your own project.

# How to deploy your project's web site

## Setup

```
1. cd site
2. svn co https://svn.apache.org/repos/asf/incubator/toree/site target
3. Jekyll requires ruby, more details on https://jekyllrb.com/docs/installation
4. gem install --user-install bundler github-pages jekyll
5. add local .gem directory to path
5.1 echo 'export PATH="$HOME/.gem/ruby/X.X.0/bin:$PATH"' >> ~/.bash_profile
6. bundle install
```

## Add javadoc

If your project supports javadoc, you can copy the generated javadoc
into svn each time you need to re-generate.

```
1. cd ..
2. mvn -DskipTests site
3. mv target/site/apidocs site/target
```

## Running locally

Before opening a pull request, you can preview your contributions by
running from within the directory:

```
1. bundle exec jekyll serve --watch
2. Open [http://localhost:4000](http://localhost:4000)
```

## Pushing to site

```
1. cd site/target
2. svn status
3. You'll need to `svn add` any new files
4. svn ci
```

Within a few minutes, svnpubsub should kick in and you'll be able to
see the results at
[foo.apache.org](https://toree.apache.org/).

## Adding contributors

To add a contributor to the project, or to modify existing contributors,
edit `site/_data/contributors.yml`.
The [project members]([http://localhost:4000/community.html#project-members]
list will re-generate.
