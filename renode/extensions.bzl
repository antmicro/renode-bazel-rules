load("@bazel_tools//tools/build_defs/repo:local.bzl", "new_local_repository")

_DEFAULT_PORTABLE_RENODE = {
    "name": "renode_default_toolchain",
    "url": "https://builds.renode.io/renode-1.15.3+20250530git063124cbc.linux-portable-dotnet.tar.gz",
    "sha256": "f4c7a4c5b7d852c633be0a309698cae34c3e0c4c801678d60c314d82597b26d4",
}

def _portable_renode_toolchain_repository_impl(repository_ctx):
    """Creates a repository with a single Renode runtime"""
    repository_ctx.report_progress("Downloading Renode...")
    repository_ctx.download_and_extract(
        repository_ctx.attr.url,
        sha256 = repository_ctx.attr.sha256,
    )
    repository_ctx.file(
        "BUILD.bazel",
        content = repository_ctx.attr.build_file_content,
    )

def _renode_build_file_variables(renode_dir, cosimulation_dir):
    return """\
_RENODE_DIRECTORY = "%s"
_COSIMULATION_DIRECTORY = "%s"
""" % (renode_dir, cosimulation_dir)

def _renode_impl(module_ctx):
    toolchains = []
    build_file = module_ctx.read(Label("//renode:renode.BUILD.bazel"))

    build_file_portable = _renode_build_file_variables(
        "renode_*/",
        "renode_*/plugins/**/IntegrationLibrary/",
    ) + build_file
    for mod in module_ctx.modules:
        for tag in mod.tags.download_portable:
            toolchains.append(tag.name)
            portable_renode_repository(
                name = tag.name,
                url = tag.url,
                sha256 = tag.sha256,
                build_file_content = build_file_portable,
            )

    build_file_local_build = _renode_build_file_variables(
        "",
        "src/Plugins/**/IntegrationLibrary/",
    ) + build_file
    for mod in module_ctx.modules:
        for tag in mod.tags.local_build:
            toolchains.append(tag.name)
            new_local_repository(
                name = tag.name,
                path = tag.path,
                build_file_content = build_file_local_build,
            )

    if len(toolchains) == 0:
        toolchains.append(_DEFAULT_PORTABLE_RENODE["name"])
        portable_renode_repository(
            build_file_content = build_file_portable,
            **_DEFAULT_PORTABLE_RENODE
        )

    renode_toolchains_repository(
        name = "renode_toolchains",
        toolchains = toolchains,
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
            impl = "@%s//:toolchain_impl" % toolchain_repo,
        ))

    repository_ctx.file("BUILD.bazel", "\n".join(build_file))

portable_renode_repository = repository_rule(
    implementation = _portable_renode_toolchain_repository_impl,
    attrs = {
        "url": attr.string(
            mandatory = True,
        ),
        "sha256": attr.string(),
        "build_file_content": attr.string(),
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

_download_portable = tag_class(
    doc = "Downloads a portable Renode to a repository of the passed name",
    attrs = {
        "name": attr.string(),
        "url": attr.string(),
        "sha256": attr.string(),
    },
)

_local_build = tag_class(
    doc = "Copies a localy built Renode to a repository of the passed name, it isn't hermetic",
    attrs = {
        "name": attr.string(),
        "path": attr.string(),
    },
)

renode = module_extension(
    implementation = _renode_impl,
    doc = "Extension used to manage Renode runtimes available as toolchains",
    tag_classes = {
        "download_portable": _download_portable,
        "local_build": _local_build,
    },
)
