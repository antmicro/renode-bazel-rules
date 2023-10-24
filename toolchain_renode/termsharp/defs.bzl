load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def install_termsharp():
    git_repository(
        name = "termsharp",
        commit = "65e67ba8de742670fd57aca62f11037d93628404",
        remote = "https://github.com/antmicro/termsharp",
        build_file = "//toolchain_renode/termsharp:termsharp.BUILD",
    )
