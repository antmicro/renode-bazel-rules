load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

package(default_visibility = ["//visibility:public"])

csharp_library(
    name = "Xwt",
    srcs = ["@renode_sources//:Xwt"],
    internals_visible_to = ["lib_xwt"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [],
    defines = ["NET", "XWT_GTK3"],
)

csharp_library(
    name = "XwtGtk",
    srcs = ["@renode_sources//:XwtGtk"],
    internals_visible_to = ["lib_xwtgtk"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [
        ":Xwt",
        "@resources//gtksharp",
        "@resources//atksharp",
        "@resources//glibsharp",
        "@resources//cairosharp",
        "@resources//gdksharp",
        "@resources//giosharp",
        "@resources//pangosharp",
    ],
    defines = ["NET", "XWT_GTK3"],
    allow_unsafe_blocks = True,
    langversion = "8",
)

