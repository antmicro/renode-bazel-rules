load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

package(default_visibility = ["//visibility:public"])

csharp_library(
    name = "TermSharp",
    srcs = ["@renode_sources//:termsharp"],
    internals_visible_to = ["lib_termsharp"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [
        "//toolchain_renode/Xwt:Xwt",
    ],
    defines = ["NET"],
)

