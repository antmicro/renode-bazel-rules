load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def install_libtftp():
    git_repository(
        name = "libtftp",
        commit = "0c2afc00935c2299ae20e6bda8909531393ea8d4",
        remote = "https://github.com/antmicro/InpliTftpServer",
        build_file = "//toolchain_renode/InpliTftpServer:libtftp.BUILD",
    )
