load("//toolchain_renode/resources:resources.bzl", "resources")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def install_xwt():
    resources()

    git_repository(
        name = "Xwt",
        commit = "01e19b676fbab339cc69ef8b8cc46065609e9e3a",
        remote = "https://github.com/antmicro/xwt",
        build_file = "//toolchain_renode/Xwt:xwt.BUILD",
    )
