# Bazel rules for Renode

Copyright (c) 2021 [Antmicro](https://www.antmicro.com/)

This repository contains rules for running Renode tests inside Bazel and provides use case examples.

In order to guarantee hermeticity of tests, the ``renode_test`` rule uses Renode portable and Python 3.8 (together with dependencies) as a hermetic toolchain.
The implication of this is that it's not necessary to install any of the aforementioned pieces of software on the host machine in order to run tests.

## Running an example

An example that tests an ELF binary with Zephyr OS compiled for the [NXP FRDM-K64F](https://www.nxp.com/design/development-boards/freedom-development-boards/mcu-boards/freedom-development-platform-for-kinetis-k64-k63-and-k24-mcus:FRDM-K64F) platform is provided in `examples/nxp-k64f`.

In order to run this test, issue `bazel test //examples/nxp-k64f:nxp-k64f-test`.

After the test has completed (irrespectively of its status), you'll find the resulting artifacts (logs, report, etc) in the `bazel-testlogs/examples/nxp/nxp-k64f-test/test.outputs` directory in the `outputs.zip` file.
