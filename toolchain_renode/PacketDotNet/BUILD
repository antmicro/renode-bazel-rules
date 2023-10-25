load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

package(default_visibility = ["//visibility:public"])

csharp_library(
    name = "PacketDotNet",
    srcs = ["@renode_sources//:PacketDotNet"],
    internals_visible_to = ["lib_packetdotnet"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [],
    defines = ["NET"],
)

