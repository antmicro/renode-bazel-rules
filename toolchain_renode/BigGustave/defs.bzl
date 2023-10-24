load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def install_biggustave():
    git_repository(
        name = "BigGustave",
        commit = "8f1810e77cf8a3ed9c460a0ee37317cec822d484",
        remote = "https://github.com/antmicro/BigGustave",
        build_file = "//toolchain_renode/BigGustave:biggustave.BUILD",
    )
