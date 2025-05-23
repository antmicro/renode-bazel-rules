# Bazel rules for Renode

Copyright (c) 2021-2025 [Antmicro](https://www.antmicro.com/)

This repository contains rules for running Renode tests inside Bazel and provides use case examples.

In order to guarantee hermeticity of tests, the ``renode_test`` rule uses Renode portable and Python 3.11 (together with dependencies) as a hermetic toolchain.
The implication of this is that it's not necessary to install any of the aforementioned pieces of software on the host machine in order to run tests.

## Running an example

An example that tests an ELF binary with HiRTOS compiled for Cortex-R52 is provided in `examples/cortex-r52`.

In order to run this test, issue `bazel test //:cortex-r52-test` in the example directory.

After the test has completed (irrespectively of its status), you'll find the resulting artifacts (logs, report, etc) in the `bazel-testlogs/examples/cortex-r52-test/test.outputs` directory in the `outputs.zip` file.
