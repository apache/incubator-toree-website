---
layout: docpage
title: Sharing spark contexts
type: doc
section: advanced
weight: 60
tagline: Apache Project !
---


# Sharing a spark context between from Toree with ipykernel

## Rationale

Sometimes you want to be able to connect to the spark context used by an
Apache Toree kernel and do some plotting in matplotlib making use of some of the
features exposed by `ipykernel`.  

This is luckily relatively easy to do for python.  

## Example

For this you will need to run two notebooks.  One with a Toree kernel and the
other running ipykernel

### In the toree kernel

```scala

import py4j.GatewayServer
// Creates a Py4J Gateway server with our spark context as the entry point
val gatewayServer: GatewayServer = new GatewayServer(kernel.javaSparkContext, 0)
gatewayServer.start()

// Get the port assignment for the py4j gateway server
val boundPort: Int = gatewayServer.getListeningPort
boundPort
```

### In an ipykernel kernel

Assuming that you can import pyspark in your py4j kernel.  
For easier ways to do that see `findspark` or `spylon`.

If for example we bound the py4j gateway to `45678`.

```python
import os
from pyspark.java_gateway import launch_gateway
from pyspark import SparkContext

# Set the port that spark looks for.
os.environ["PYSPARK_GATEWAY_PORT"] = "45678"

jvm_gateway = launch_gateway()
jsc = jvm_gateway.entry_point

# Ensure that we bind the gateway we created to the current spark context
sc = SparkContext(jsc=jsc, gateway=jvm_gateway)
```

Once you've run this you should have a shared spark context available on both
kernels.
