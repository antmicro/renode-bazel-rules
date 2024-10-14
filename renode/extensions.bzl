_RENODE_TOOLCHAIN_TEMPLATE = """\
load("@rules_renode//renode:toolchain.bzl", "renode_toolchain")
filegroup(
    name = "{runtime_target_name}",
    srcs = glob(["**/*"]),
)
filegroup(
    name = "python_requirements",
    srcs = glob(["tests/requirements.txt"]),
    visibility = ["//visibility:public"],
)
filegroup(
    name = "python_requirements_dependencies",
    srcs = glob(["tools/**/requirements.txt"]),
    visibility = ["//visibility:public"],
)
renode_toolchain(
    name = "{toolchain_impl_name}",
    runtime = [":{runtime_target_name}"],
)
toolchain(
    name = "{toolchain_name}",
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":{toolchain_impl_name}",
    toolchain_type = "@rules_renode//renode:toolchain_type",
)
"""

def _portable_renode_toolchain_repository_impl(repository_ctx):
    """Creates a repository with a single Renode runtime"""
    repository_ctx.report_progress("Downloading Renode...")
    repository_ctx.download_and_extract(
        repository_ctx.attr.url,
        sha256 = repository_ctx.attr.sha256,
        stripPrefix = "renode_1.15.3_portable",
    )

    repository_ctx.file("BUILD.bazel", _RENODE_TOOLCHAIN_TEMPLATE.format(
        runtime_target_name = "runtime",
        toolchain_impl_name = "toolchain_impl",
        toolchain_name = "toolchain",
    ))

def _renode_impl(module_ctx):
    """Extension used to manage Renode runtimes available as toolchains.
    Currently only supports a single portable runtime.
    """
    portable_renode_toolchain_repository(
        name = "renode_toolchains",
        url = "https://dl.antmicro.com/projects/renode/builds/renode-1.15.3.linux-portable.tar.gz",
        sha256 = "1d313e2bca5d066b4b084c581c933b26a665be45e71b18145c1570490a0e439d",
    )

portable_renode_toolchain_repository = repository_rule(
    implementation = _portable_renode_toolchain_repository_impl,
    attrs = {
        "url": attr.string(
            mandatory = True,
        ),
        "sha256": attr.string(),
    },
)

renode = module_extension(
    implementation = _renode_impl,
)
