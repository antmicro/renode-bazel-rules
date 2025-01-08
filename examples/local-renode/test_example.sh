#! /usr/bin/env bash
set -eux -o pipefail

git clone --no-progress https://github.com/renode/renode.git
pushd renode
git checkout f677dc74c9891e2e23c5265b664e919216887ba3 # There is no tag compatible with a new name of CoSimulationPlugin.
./build.sh --net
popd
bazelisk test //:all
