---
layout: docpage
title: Test Structure of Project
type: doc
section: developer
weight: 0
tagline: Apache Project !
---

### Prerequisites

You must install the [library dependencies][1] to properly run the tests.

### Testing Levels
There are four levels of test in this project:

1. Unit - tests that isolate a specific class/object/etc for its functionality

2. Integration - tests that illustrate functionality between multiple
   components

3. System - tests that demonstrate correctness across the entire system

4. Scratch - tests isolated in a local branch, used for quick sanity checks,
   not for actual inclusion into testing solution

### Test Execution

To execute specific tests, run sbt with the following:

1. Unit - `sbt unit:test`

2. Integration - `sbt integration:test`

3. System - `sbt system:test`

4. Scratch - `sbt scratch:test`

To run all tests, use `sbt test`!

### Naming Conventions

The naming convention for tests is as follows:

1. Unit - test classes end with _Spec_
   e.g. CompleteRequestSpec
    * Placed under _com.ibm.spark_

2. Integration - test classes end with _SpecForIntegration_
   e.g. InterpreterWithActorSpecForIntegration
    * Placed under _integration_

3. System - test classes end with _SpecForSystem_
   e.g. InputToAddJarSpecForSystem
    * Placed under _system_

4. Scratch
    * Placed under _scratch_

It is also possible to run tests for a specific project by using the following
syntax in sbt:

    sbt <PROJECT>/test

[1]: Building-from-Source
