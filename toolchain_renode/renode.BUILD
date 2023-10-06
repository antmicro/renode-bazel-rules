load("@//toolchain_renode:toolchain.bzl", "renode_toolchain")
package(default_visibility = ["//visibility:public"])

# toolchain_impl gathers information about the Renode toolchain.
# See the RenodeToolchain provider.
renode_toolchain(
    name = "toolchain_impl",
)

# This target should be registered by
# calling register_toolchains in a WORKSPACE file.
toolchain(
    name = "toolchain",
    toolchain = ":toolchain_impl",
    toolchain_type = "@//:toolchain_type",
)
