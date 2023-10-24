load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def install_crypto():
    git_repository(
        name = "crypto",
        commit = "6b340565473a5375f2b139e26bf04f47849e5fa7",
        remote = "https://github.com/antmicro/bc-csharp",
        build_file = "//toolchain_renode/bc-csharp:crypto.BUILD",
    )
