load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//toolchain_renode/resources:resources.bzl", "resources")

def install_toolchain_renode():
    resources()

    http_archive(
	name = "renode-resources",
	url = "https://github.com/renode/renode-resources/archive/refs/heads/master.zip",
	sha256 = "e7009eb80dce0b46449763465a6701d06f627a4da08f04dcf433e01121660863",
	build_file = "//toolchain_renode:renode-resources.BUILD",
    )

    git_repository(
        name = "toolchain_renode",
        commit = "f86ac3cf1c836739184015c3a5a5166a4d898d20",
        init_submodules	= True,
        recursive_init_submodules = True,
        remote = "https://github.com/renode/renode",
        build_file = "@//toolchain_renode:renode.BUILD",
        # TODO: it looks like workspace_file doesn't work?
        # bazel doesn't load rules from this file before executing BUILD file
        workspace_file = "@//toolchain_renode:renode.WORKSPACE",
        patch_args = ["-p1"],
        patches = [
            "@//toolchain_renode:Migrant-Add-BUILD.bazel.patch",
            "@//toolchain_renode:AntShell-Add-BUILD.bazel.patch",
            "@//toolchain_renode:BigGustave-Add-BUILD.bazel.patch",
            "@//toolchain_renode:CxxDemangler-Add-BUILD.bazel.patch",
            "@//toolchain_renode:ELFSharp-Add-BUILD.bazel.patch",
            "@//toolchain_renode:FdtSharp-Add-BUILD.bazel.patch",
            "@//toolchain_renode:libtftp-Add-BUILD.bazel.patch",
            "@//toolchain_renode:PacketDotNet-Add-BUILD.bazel.patch",
            "@//toolchain_renode:crypto-Add-BUILD.bazel.patch",
            "@//toolchain_renode:Infrastructure-Add-BUILD.bazel.patch",
            "@//toolchain_renode:options-parser-Add-BUILD.bazel.patch",
            "@//toolchain_renode:termsharp-Add-BUILD.bazel.patch",
            "@//toolchain_renode:Xwt-Add-BUILD.bazel.patch",
            "@//toolchain_renode:Renode-Add-BUILD.bazel.patch",
        ],
    )
