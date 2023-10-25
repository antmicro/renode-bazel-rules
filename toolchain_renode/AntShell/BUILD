load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

package(default_visibility = ["//visibility:public"])

csharp_library(
    name = "AntShell",
    srcs = ["@renode_sources//:AntShell"],
    internals_visible_to = ["lib_antshell"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [
        "//toolchain_renode/Migrant:Migrant",
    ],
    defines = ["NET"],
)

