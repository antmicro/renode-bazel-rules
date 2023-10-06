load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_dotnet",
    sha256 = "5667f2dffb40890951662ec515bc2d5fca73126fbb69607b2ab451a644cc986d",
    strip_prefix = "rules_dotnet-0.11.0",
    url = "https://github.com/bazelbuild/rules_dotnet/releases/download/v0.11.0/rules_dotnet-v0.11.0.tar.gz",
)

load(
    "@rules_dotnet//dotnet:repositories.bzl",
    "dotnet_register_toolchains",
    "rules_dotnet_dependencies",
)

rules_dotnet_dependencies()

# Here you can specify the version of the .NET SDK to use.
dotnet_register_toolchains("dotnet", "7.0.101")

load("@rules_dotnet//dotnet:rules_dotnet_nuget_packages.bzl", "rules_dotnet_nuget_packages")

rules_dotnet_nuget_packages()

http_archive(
    name = "renode-resources",
    url = "https://github.com/renode/renode-resources/archive/refs/heads/master.zip",
    sha256 = "e7009eb80dce0b46449763465a6701d06f627a4da08f04dcf433e01121660863",
    build_file = "@//:renode-resources.BUILD",
)

load("//deps:resources.bzl", "resources")

resources()
