def _portable_renode_toolchain_repository_impl(repository_ctx):
    """Creates a repository with a single Renode runtime"""
    repository_ctx.report_progress("Downloading Renode...")
    repository_ctx.download_and_extract(
        repository_ctx.attr.url,
        sha256 = repository_ctx.attr.sha256,
    )
    repository_ctx.template("BUILD.bazel", Label("//renode:renode.BUILD.bazel"))

def _renode_impl(module_ctx):
    default_toolchain = "renode_default_toolchain"
    portable_renode_repository(
        name = default_toolchain,
        url = "https://builds.renode.io/renode-1.15.3+20250113gite77cf1237.linux-portable-dotnet.tar.gz",
        sha256 = "a6242b628b49b8a254358fe399ad49f0838c708abe44c551321c9555b7bff873",
    )

    renode_toolchains_repository(
        name = "renode_toolchains",
        toolchains = [default_toolchain],
    )

_RENODE_TOOLCHAIN_TEMPLATE = """\
toolchain(
    name = "{name}",
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    toolchain = "{impl}",
    toolchain_type = "@rules_renode//renode:toolchain_type",
    visibility = ["//visibility:public"],
)
"""

def _renode_toolchains_repository(repository_ctx):
    build_file = []
    for toolchain_repo in repository_ctx.attr.toolchains:
        build_file.append(_RENODE_TOOLCHAIN_TEMPLATE.format(
            name = toolchain_repo,
            impl = Label("@%s//:toolchain_impl" % toolchain_repo),
        ))

    repository_ctx.file("BUILD.bazel", "\n".join(build_file))

portable_renode_repository = repository_rule(
    implementation = _portable_renode_toolchain_repository_impl,
    attrs = {
        "url": attr.string(
            mandatory = True,
        ),
        "sha256": attr.string(),
    },
)

renode_toolchains_repository = repository_rule(
    implementation = _renode_toolchains_repository,
    attrs = {
        "toolchains": attr.string_list(
            mandatory = True,
        ),
    },
)

renode = module_extension(
    implementation = _renode_impl,
    doc = "Extension used to manage Renode runtimes available as toolchains",
)
