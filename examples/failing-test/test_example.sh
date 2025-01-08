#! /usr/bin/env bash
set -eux -o pipefail

! bazelisk test //:all > test.log || exit 1 # Check if a failing Robot test causes a Bazel fail
ls bazel-testlogs/*/test.outputs/outputs.zip
grep -E "//:success-test +PASSED" test.log
grep -E "//:failing-test +FAILED" test.log
