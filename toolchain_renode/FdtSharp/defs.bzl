load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def install_fdtsharp():

    git_repository(
        name = "FdtSharp",
        commit = "2e14146fcb7397d6f2dac7fac72947398f715a81",
        remote = "https://github.com/antmicro/FdtSharp",
        build_file = "//toolchain_renode/FdtSharp:fdtsharp.BUILD",
    )
