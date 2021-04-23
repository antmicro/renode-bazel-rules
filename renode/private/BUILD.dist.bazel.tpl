# This template is used by perl_download to generate a build file for
# a downloaded Renode distribution.

load("@rules_renode//renode:toolchain.bzl", "renode_toolchain")
package(default_visibility = ["//visibility:public"])

# tools contains executable files that are part of the toolchain.
filegroup(
    name = "runtime",
    srcs = glob(["**/*"]),
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
    toolchain_type = "@rules_renode//:toolchain_type",
)
