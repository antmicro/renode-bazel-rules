load("@//toolchain_renode:toolchain.bzl", "renode_toolchain")
load("@//toolchain_renode:copy.bzl", "copy")
package(default_visibility = ["//visibility:public"])

toolchain_type(
    name = "toolchain_type",
    visibility = ["//visibility:public"],
)

copy(
    name = "copy_styles_robot",
    src = "@renode-resources//:robot-style",
    out = "lib/resources/styles/robot.css",
)

filegroup(
    name = "platforms",
    srcs = glob(["platforms/**/*"]),
)

filegroup(
    name = "scripts",
    srcs = glob(["scripts/**/*"]),
)

# tools contains executable files that are part of the toolchain.
filegroup(
    name = "runtime",
    srcs = [
        "renode",
        "renode-test",
        "tools/common.sh",
        "tests/run_tests.py",
        "tests/tests.yaml",
        ".renode-root",
        "//:platforms",
        "//:scripts",
        "//:copy_styles_robot",
        "//src/Renode:publish_renode",
    ]
)

# toolchain_impl gathers information about the Renode toolchain.
# See the RenodeToolchain provider.
renode_toolchain(
    name = "toolchain_impl",
    runtime = [":runtime"],
)

# This target should be registered by
# calling register_toolchains in a WORKSPACE file.
toolchain(
    name = "toolchain",
    toolchain = ":toolchain_impl",
    toolchain_type = "//:toolchain_type",
)
