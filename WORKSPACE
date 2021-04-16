workspace(name = 'rules_renode')

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")
load("//renode:deps.bzl", "renode_register_toolchain")

renode_register_toolchain()

http_file(
    name = "nxp_k64f--zephyr_basic_uart.elf",
    urls = ["https://dl.antmicro.com/projects/renode/nxp_k64f--zephyr_basic_uart.elf-s_618844-2d588c6899efaae76a7a27136fd8cff667bbcb6f"],
    sha256 = "db432c3efa414a365dc55cdbffb29ed827914d7ef2d7a605cad981a2b349042d",
)
