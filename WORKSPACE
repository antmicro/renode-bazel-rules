workspace(name = "com_antmicro_renode")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

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
load("@rules_dotnet//dotnet:rules_dotnet_dev_nuget_packages.bzl", "rules_dotnet_dev_nuget_packages")

rules_dotnet_nuget_packages()

rules_dotnet_dev_nuget_packages()

load("//toolchain_renode:defs.bzl", "fetch_renode_sources")

fetch_renode_sources()

http_archive(
    name = "rules_python",
    sha256 = "778197e26c5fbeb07ac2a2c5ae405b30f6cb7ad1f5510ea6fdac03bded96cc6f",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.2.0/rules_python-0.2.0.tar.gz",
)

load("@rules_python//python:pip.bzl", "pip_install")

pip_install(
    name = "renode_robot_deps",
    extra_pip_args = ["-v"],
    python_interpreter = "python3",
    quiet = False,
    requirements = "@toolchain_renode//:tests/requirements.txt",
)

http_file(
    name = "nxp_k64f--zephyr_basic_uart.elf",
    sha256 = "db432c3efa414a365dc55cdbffb29ed827914d7ef2d7a605cad981a2b349042d",
    urls = ["https://dl.antmicro.com/projects/renode/nxp_k64f--zephyr_basic_uart.elf-s_618844-2d588c6899efaae76a7a27136fd8cff667bbcb6f"],
)
