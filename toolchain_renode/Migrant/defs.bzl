load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def install_migrant():
    git_repository(
        name = "Migrant",
        commit = "75d5eaaabd30d28f0f5a1168ad677fd12edeb120",
        remote = "https://github.com/antmicro/Migrant",
        build_file = "//toolchain_renode/Migrant:migrant.BUILD",
    )
