---
layout: docpage
title: Using Docker
type: doc
section: quick-start
weight: 0
tagline: Apache Project !
---

The Spark Kernel can be run in a docker container using Docker 1.0.0+. There is 
a Dockerfile included in the root of the project. You will need to compile and 
pack the Spark Kernel before the docker image can be built.

    sbt compile
    sbt pack
    docker build -t spark-kernel .

After the image has been successfully created, you can run your container by 
executing the command:

    docker run -d -e IP=0.0.0.0 spark-kernel 

You must always include `-e IP=0.0.0.0` to allow the kernel to bind to the 
docker container's IP. The environment variables listed in the getting 
started section can be used in the docker run command. This allows you to 
explicitly set the ports for the kernel.
