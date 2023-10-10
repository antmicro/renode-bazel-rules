load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("//toolchain_renode/Migrant:defs.bzl", "install_migrant")

def install_antshell():
    install_migrant()

    git_repository(
        name = "AntShell",
        commit = "f60a3750ebcd72490b475963a62a779d7a9c730d",
        remote = "https://github.com/antmicro/AntShell",
        build_file = "//toolchain_renode/AntShell:antshell.BUILD",
        patch_args = ["-p1"],
        patches = [
            "@//toolchain_renode/AntShell:Set-AssemblyVersion.patch",
        ]
    )
