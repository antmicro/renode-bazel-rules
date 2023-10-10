load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

package(default_visibility = ["//visibility:public"])

csharp_library(
    name = "FdtSharp",
    srcs = [
     "FdtSharp/FlattenedDeviceTree.cs",
     "FdtSharp/Properties/AssemblyInfo.cs",
     "FdtSharp/Property.cs",
     "FdtSharp/ReservationBlock.cs",
     "FdtSharp/StringReader.cs",
     "FdtSharp/StringWriter.cs",
     "FdtSharp/Token.cs",
     "FdtSharp/TreeNode.cs",
     "FdtSharp/Utilities.cs",
    ],
    internals_visible_to = ["lib_fdtsharp"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [
    ],
    defines = ["NET"],
    allow_unsafe_blocks = True,
)
