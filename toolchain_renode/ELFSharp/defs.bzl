load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def install_elfsharp():

    git_repository(
        name = "ELFSharp",
        commit = "1a3dbe3f4e76ff624d53d61d9d8275c4a2535416",
        remote = "https://github.com/antmicro/elfsharp",
        build_file = "//toolchain_renode/ELFSharp:elfsharp.BUILD",
    )
