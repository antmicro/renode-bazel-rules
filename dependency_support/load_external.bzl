load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("//dependency_support/renode-resources:resources.bzl", "renode_resources")

def load_external_repositories():
    http_archive(
        name = "rules_dotnet",
        sha256 = "5667f2dffb40890951662ec515bc2d5fca73126fbb69607b2ab451a644cc986d",
        strip_prefix = "rules_dotnet-0.11.0",
        url = "https://github.com/bazelbuild/rules_dotnet/releases/download/v0.11.0/rules_dotnet-v0.11.0.tar.gz",
    )

    http_archive(
        name = "rules_python",
        sha256 = "9d04041ac92a0985e344235f5d946f71ac543f1b1565f2cdbc9a2aaee8adf55b",
        strip_prefix = "rules_python-0.26.0",
        url = "https://github.com/bazelbuild/rules_python/releases/download/0.26.0/rules_python-0.26.0.tar.gz",
    )

    http_file(
        name = "nxp_k64f--zephyr_basic_uart.elf",
        sha256 = "db432c3efa414a365dc55cdbffb29ed827914d7ef2d7a605cad981a2b349042d",
        urls = ["https://dl.antmicro.com/projects/renode/nxp_k64f--zephyr_basic_uart.elf-s_618844-2d588c6899efaae76a7a27136fd8cff667bbcb6f"],
    )
