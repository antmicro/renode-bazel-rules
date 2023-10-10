load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def install_tlib():

    git_repository(
        name = "tlib",
        commit = "adb801dbff98d1114e6346af4115edfc2bd33a1b",
        remote = "https://github.com/antmicro/tlib",
        build_file = "//toolchain_renode/tlib:tlib.BUILD",
    )
