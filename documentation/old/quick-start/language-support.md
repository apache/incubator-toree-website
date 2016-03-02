---
layout: docpage
title: Language Support
type: doc
section: quick-start
weight: 0
tagline: Apache Project !
---


The Spark Kernel supports the following languages: [Scala](#scala), [Python](#python), [R](#r), and [SQL](#sql). As of version 0.1.5 of the Spark Kernel, only Scala is considered stable.

The language support for Python and R requires the system running the Spark Kernel to also contain a Python and R runtime, respectively. Furthermore, when using R, the location of R's site packages needs to be writable by the Spark Kernel. This is due to the current setup required to be able to run R code using the SparkR library.

_Note: Currently, only Scala supports evaluating magics and using the Comm API._

### Setting the default language

To change the default language of the Spark Kernel, you can provide an environment variable or a command line option.

| Language | Spark Implementation | Value to provide to Spark Kernel |
|----------|----------------------|----------------------------------|
| Scala    | Scala with Spark     | Scala                            |
| Python   | Python with PySpark  | PySpark                          |
| R        | R with SparkR        | SparkR                           |
| SQL      | Spark SQL            | SQL                              |

_Note: Values provided to the Spark Kernel are case insensitive, meaning SparkR is the same as sparkr._


Using bash:

```bash
DEFAULT_INTERPRETER=pyspark <spark-kernel-dist>/bin/spark-kernel
```

```bash
<spark-kernel-dist>/bin/spark-kernel --default-interpreter pyspark
```

### Scala

The Scala language is the default language used by the Spark Kernel. Any code sent to the Spark Kernel will be executed as Scala.

```scala
println(sc.parallelize(1 to 100).reduce(_ + _))
```

The Scala interpreter can also be invoked via an equivalent magic.

```scala
%%scala println(sc.parallelize(1 to 100).reduce(_ + _))
```

### Python

The Python language uses PySpark to interact with Spark. Use the `%%pyspark` magic to run code using Python.

```python
%%pyspark print sc.parallelize(range(1, 101)).reduce(lambda a,b: a+b)
```

##### Requirements
* A local copy of the Apache Spark distribution that you should point to via _SPARK\_HOME_. 
* Add the PySpark library (and other associated libraries) to your Python path.

An example of a Jupyter configuration with the property PySpark information set is as follows:

```json
{
    "display_name": "Spark 1.5.1 (PySpark)",
    "language_info": { "name": "python" },
    "argv": [
        "/home/vagrant/local/bin/sparkkernel",
        "--profile",
        "{connection_file}"
    ],
    "codemirror_mode": "python",
    "env": {
        "SPARK_HOME": "/opt/spark",
        "PYTHONPATH": "/opt/spark/python:/opt/spark/python/lib/py4j-0.8.2.1-src.zip"
     }
}
```

> Note: <br>
> The _PYTHONPATH_ environment variable is set to `/opt/spark/python:/opt/spark/python/lib/py4j-0.8.2.1-src.zip`, which contains the path to the PySpark library as well as inclusion of a provided copy of Py4J (needed for the PySpark library).

### R

The R language used SparkR to interact with Spark. Use the `%%sparkr` magic to run code using R.

```r
%%sparkr
df <- createDataFrame(sqlContext, faithful)
head(df)
```

> Note: <br>
> The R language uses a forked SparkR implementation underneath. The forking of SparkR was required to expose certain APIs to access the JVM and allow connecting to an existing Spark Context. 

##### Requirements
* R version 3.2+ 
* A local copy of the Apache Spark distribution that you should point to via _SPARK\_HOME_. 
* Make sure that the packages directory used by R when installing packages is writable, necessary to installed modified SparkR library. This is done automatically before any R code is run. 

If the package directory is not writable by the Spark Kernel, then you should see an error similar to the following:

```
Installing package into ‘/usr/local/lib/R/site-library’
(as ‘lib’ is unspecified)
Warning in install.packages("sparkr_bundle.tar.gz", repos = NULL, type = "source") :
'lib = "/usr/local/lib/R/site-library"' is not writable
Error in install.packages("sparkr_bundle.tar.gz", repos = NULL, type = "source") :
unable to install packages
Execution halted
```

### SQL

The SQL language uses Spark SQL underneath. This serves as a wrapper around the standard `sparkSql.sql("YOUR SQL CODE")`. No additional setup is necessary to use Spark SQL.

While the SQL interpreter can be set as the default, as Hive support has not yet been included directly in the Spark Kernel, it is recommended to use the SQL magic instead to access data stored via languages like Scala.

```scala
val df = sqlContext.read.json("/opt/spark/examples/src/main/resources/people.json")
df.registerTempTable("mytable")
```

```sql
%%sql SELECT age FROM mytable
```
