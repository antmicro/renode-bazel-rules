load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

package(default_visibility = ["//visibility:public"])

csharp_library(
    name = "BigGustave",
    srcs = ["@renode_sources//:BigGustave"],
    internals_visible_to = ["lib_biggustave"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [],
    defines = ["NET"],
)

