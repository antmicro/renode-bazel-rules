load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def install_packetdotnet():
    git_repository(
        name = "PacketDotNet",
        commit = "8ddb5d3cd657435ff60b86d30089a0b828a75ff8",
        remote = "https://github.com/antmicro/Packet.Net",
        build_file = "//toolchain_renode/PacketDotNet:packetdotnet.BUILD",
    )
