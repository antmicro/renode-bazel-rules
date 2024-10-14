load("@rules_renode//renode:defs.bzl", "renode_test")

renode_test(
    name = "nxp-k64f-test",
    elf_file_variable = "@nxp_k64f--zephyr_basic_uart.elf//file",
    robot_test = "NXP-K64F.robot",
    tags = ["no-sandbox"],
    timeout = "short",
)
