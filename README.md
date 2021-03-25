# Bazel rules for Renode

This repository contains rules for running Renode tests inside Bazel and provides use case examples.

Currently, it is required that Renode is installed in the host operating system (if you're not sure how to do that, follow the instructions from the [documentation](https://renode.readthedocs.io/en/latest/introduction/installing.html))

## Running an example

An example that tests an ELF binary with Zephyr OS compiled for the [NXP FRDM-K64F](https://www.nxp.com/design/development-boards/freedom-development-boards/mcu-boards/freedom-development-platform-for-kinetis-k64-k63-and-k24-mcus:FRDM-K64F) platform is provided in `examples/nxp`.

In order to run this test, issue `bazel test //examples/nxp:nxp-k64f-test`.

After the test has completed (irrespectively of its status), you'll find the resulting artifacts (logs, report, etc) in the `bazel-testlogs/examples/nxp/nxp-k64f-test/test.outputs` directory in the `outputs.zip` file.
