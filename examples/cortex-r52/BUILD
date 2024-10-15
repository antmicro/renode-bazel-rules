load("@rules_renode//renode:defs.bzl", "renode_test")

renode_test(
    name = "cortex-r52-test",
    timeout = "short",
    files = [
        "@cortex-r52-hirtos-hello//file",
    ],
    files_variable_names = [
        "ELF",
    ],
    robot_test = "test.robot",
)
