#! /usr/bin/env bash
set -eux -o pipefail

bazelisk test //:all
ls bazel-testlogs/*/test.outputs/outputs.zip
