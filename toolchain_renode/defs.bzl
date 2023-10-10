load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//toolchain_renode/resources:resources.bzl", "resources")
load("//toolchain_renode/Migrant:defs.bzl", "install_migrant")
load("//toolchain_renode/AntShell:defs.bzl", "install_antshell")
load("//toolchain_renode/BigGustave:defs.bzl", "install_biggustave")
load("//toolchain_renode/CxxDemangler:defs.bzl", "install_cxxdemangler")
load("//toolchain_renode/ELFSharp:defs.bzl", "install_elfsharp")
load("//toolchain_renode/FdtSharp:defs.bzl", "install_fdtsharp")
load("//toolchain_renode/InpliTftpServer:defs.bzl", "install_libtftp")
load("//toolchain_renode/PacketDotNet:defs.bzl", "install_packetdotnet")
load("//toolchain_renode/bc-csharp:defs.bzl", "install_crypto")
load("//toolchain_renode/options-parser:defs.bzl", "install_optionsparser")
load("//toolchain_renode/Xwt:defs.bzl", "install_xwt")
load("//toolchain_renode/termsharp:defs.bzl", "install_termsharp")
load("//toolchain_renode/renode-infrastructure:defs.bzl", "install_renode_infrastructure")

def install_toolchain_renode():
    resources()
    install_migrant()
    install_antshell()
    install_biggustave()
    install_cxxdemangler()
    install_elfsharp()
    install_fdtsharp()
    install_libtftp()
    install_packetdotnet()
    install_crypto()
    install_optionsparser()
    install_xwt()
    install_termsharp()
    install_renode_infrastructure()

    http_archive(
	name = "renode-resources",
	url = "https://github.com/renode/renode-resources/archive/refs/heads/master.zip",
	sha256 = "e7009eb80dce0b46449763465a6701d06f627a4da08f04dcf433e01121660863",
	build_file = "//toolchain_renode:renode-resources.BUILD",
    )

    git_repository(
        name = "toolchain_renode",
        commit = "f86ac3cf1c836739184015c3a5a5166a4d898d20",
        remote = "https://github.com/renode/renode",
        build_file = "@//toolchain_renode:renode.BUILD",
    )

    native.register_toolchains(
	"@toolchain_renode//:toolchain"
    )
