package(default_visibility = ["//visibility:public"])

load("//toolchain_renode:renode.bzl", "renode_test")

renode_test(
    name = "nxp-k64f-test",
    binary = "@nxp_k64f--zephyr_basic_uart.elf//file",
    robot = ["NXP-K64F.robot"],
)
