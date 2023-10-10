load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("//toolchain_renode/resources:resources.bzl", "resources")
load("//toolchain_renode/Migrant:defs.bzl", "install_migrant")
load("//toolchain_renode/ELFSharp:defs.bzl", "install_elfsharp")
load("//toolchain_renode/PacketDotNet:defs.bzl", "install_packetdotnet")
load("//toolchain_renode/CxxDemangler:defs.bzl", "install_cxxdemangler")
load("//toolchain_renode/AntShell:defs.bzl", "install_antshell")
load("//toolchain_renode/Xwt:defs.bzl", "install_xwt")
load("//toolchain_renode/BigGustave:defs.bzl", "install_biggustave")
load("//toolchain_renode/termsharp:defs.bzl", "install_termsharp")

def install_renode_infrastructure():
    resources()
    install_migrant()
    install_elfsharp()
    install_packetdotnet()
    install_cxxdemangler()
    install_antshell()
    install_xwt()
    install_biggustave()
    install_termsharp()

    git_repository(
        name = "RenodeInfrastructure",
        commit = "edc0b9f89eed551f043212ed102cfb1d87b01bae",
        remote = "https://github.com/renode/renode-infrastructure",
        build_file = "//toolchain_renode/renode-infrastructure:infrastructure.BUILD",
        recursive_init_submodules = True,
    )
