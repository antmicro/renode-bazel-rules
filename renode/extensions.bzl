load("@bazel_tools//tools/build_defs/repo:local.bzl", "new_local_repository")

# Default portable Renode builds for different platforms
_DEFAULT_LINUX_X64 = {
    "name": "renode_linux_x64",
    "url": "https://github.com/renode/renode/releases/download/v1.16.0/renode-1.16.0.linux-portable-dotnet.tar.gz",
    "sha256": "",  # Will be filled after verification
    "os": "linux",
    "cpu": "x86_64",
}

_DEFAULT_LINUX_ARM64 = {
    "name": "renode_linux_arm64",
    "url": "https://github.com/renode/renode/releases/download/v1.16.0/renode-1.16.0.linux-arm64-portable-dotnet.tar.gz",
    "sha256": "",
    "os": "linux",
    "cpu": "aarch64",
}

_DEFAULT_MACOS_ARM64 = {
    "name": "renode_macos_arm64",
    "url": "https://github.com/renode/renode/releases/download/v1.16.0/renode-1.16.0-dotnet.osx-arm64-portable.dmg",
    "sha256": "",
    "os": "macos",
    "cpu": "aarch64",
}

_DEFAULT_MACOS_X64 = {
    "name": "renode_macos_x64",
    "url": "https://github.com/renode/renode/releases/download/v1.16.0/renode_1.16.0.dmg",
    "sha256": "",
    "os": "macos",
    "cpu": "x86_64",
}

def _portable_renode_toolchain_repository_impl(repository_ctx):
    """Creates a repository with a single Renode runtime from tar.gz"""
    repository_ctx.report_progress("Downloading Renode...")
    if repository_ctx.attr.sha256:
        repository_ctx.download_and_extract(
            repository_ctx.attr.url,
            sha256 = repository_ctx.attr.sha256,
        )
    else:
        repository_ctx.download_and_extract(
            repository_ctx.attr.url,
        )
    repository_ctx.file(
        "BUILD.bazel",
        content = repository_ctx.attr.build_file_content,
    )

def _dmg_renode_toolchain_repository_impl(repository_ctx):
    """Creates a repository with a single Renode runtime from DMG (macOS)"""
    repository_ctx.report_progress("Downloading Renode DMG...")

    # Download the DMG file
    dmg_path = "renode.dmg"
    if repository_ctx.attr.sha256:
        repository_ctx.download(
            repository_ctx.attr.url,
            output = dmg_path,
            sha256 = repository_ctx.attr.sha256,
        )
    else:
        repository_ctx.download(
            repository_ctx.attr.url,
            output = dmg_path,
        )

    # Mount, copy, and unmount the DMG
    repository_ctx.report_progress("Extracting Renode from DMG...")

    # Create mount point
    mount_point = "dmg_mount"
    repository_ctx.execute(["mkdir", "-p", mount_point])

    # Mount DMG (read-only, no browse)
    result = repository_ctx.execute([
        "hdiutil", "attach", dmg_path,
        "-mountpoint", mount_point,
        "-nobrowse", "-readonly", "-noverify"
    ])
    if result.return_code != 0:
        fail("Failed to mount DMG: " + result.stderr)

    # Find and copy the Renode.app or renode directory
    # The DMG typically contains a Renode.app bundle
    result = repository_ctx.execute(["ls", mount_point])
    repository_ctx.report_progress("DMG contents: " + result.stdout)

    # Copy contents - handle both .app bundle and direct directory
    # Create the renode directory to match expected structure
    repository_ctx.execute(["mkdir", "-p", "renode"])

    # Try to copy from Renode.app/Contents/MacOS structure
    cp_result = repository_ctx.execute([
        "sh", "-c",
        "if [ -d '%s/Renode.app/Contents/MacOS' ]; then " % mount_point +
        "cp -R '%s/Renode.app/Contents/MacOS/'* renode/; " % mount_point +
        "elif [ -d '%s/Renode' ]; then " % mount_point +
        "cp -R '%s/Renode/'* renode/; " % mount_point +
        "else " +
        "cp -R '%s/'* renode/ 2>/dev/null || true; " % mount_point +
        "fi"
    ])

    # Unmount DMG
    repository_ctx.execute(["hdiutil", "detach", mount_point, "-force"])

    # Clean up
    repository_ctx.execute(["rm", "-rf", mount_point, dmg_path])

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
    toolchain_configs = []  # List of (name, os, cpu) tuples
    build_file = module_ctx.read(Label("//renode:renode.BUILD.bazel"))

    # Build file for tar.gz portable builds (Linux)
    build_file_portable = _renode_build_file_variables(
        "renode_*/",
        "renode_*/plugins/**/IntegrationLibrary/",
    ) + build_file

    # Build file for DMG builds (macOS) - different directory structure
    build_file_macos = _renode_build_file_variables(
        "renode/",
        "renode/plugins/**/IntegrationLibrary/",
    ) + build_file

    # Process user-specified portable downloads
    for mod in module_ctx.modules:
        for tag in mod.tags.download_portable:
            toolchains.append(tag.name)
            os = tag.os if tag.os else "linux"
            cpu = tag.cpu if tag.cpu else "x86_64"
            toolchain_configs.append("%s:%s:%s" % (tag.name, os, cpu))

            if os == "macos":
                dmg_renode_repository(
                    name = tag.name,
                    url = tag.url,
                    sha256 = tag.sha256,
                    build_file_content = build_file_macos,
                )
            else:
                portable_renode_repository(
                    name = tag.name,
                    url = tag.url,
                    sha256 = tag.sha256,
                    build_file_content = build_file_portable,
                )

    # Process local builds
    build_file_local_build = _renode_build_file_variables(
        "",
        "src/Plugins/**/IntegrationLibrary/",
    ) + build_file
    for mod in module_ctx.modules:
        for tag in mod.tags.local_build:
            toolchains.append(tag.name)
            os = tag.os if tag.os else "linux"
            cpu = tag.cpu if tag.cpu else "x86_64"
            toolchain_configs.append("%s:%s:%s" % (tag.name, os, cpu))
            new_local_repository(
                name = tag.name,
                path = tag.path,
                build_file_content = build_file_local_build,
            )

    # If no toolchains specified, create defaults for common platforms
    if len(toolchains) == 0:
        # Add Linux x64 (most common CI platform)
        toolchains.append(_DEFAULT_LINUX_X64["name"])
        toolchain_configs.append("%s:linux:x86_64" % _DEFAULT_LINUX_X64["name"])
        portable_renode_repository(
            name = _DEFAULT_LINUX_X64["name"],
            url = _DEFAULT_LINUX_X64["url"],
            sha256 = _DEFAULT_LINUX_X64["sha256"],
            build_file_content = build_file_portable,
        )

        # Add macOS ARM64 (Apple Silicon)
        toolchains.append(_DEFAULT_MACOS_ARM64["name"])
        toolchain_configs.append("%s:macos:aarch64" % _DEFAULT_MACOS_ARM64["name"])
        dmg_renode_repository(
            name = _DEFAULT_MACOS_ARM64["name"],
            url = _DEFAULT_MACOS_ARM64["url"],
            sha256 = _DEFAULT_MACOS_ARM64["sha256"],
            build_file_content = build_file_macos,
        )

    renode_toolchains_repository(
        name = "renode_toolchains",
        toolchains = toolchains,
        toolchain_configs = toolchain_configs,
    )

# Toolchain template with configurable platform constraints
_RENODE_TOOLCHAIN_TEMPLATE = """\
toolchain(
    name = "{name}",
    target_compatible_with = [
        "@platforms//os:{os}",
        "@platforms//cpu:{cpu}",
    ],
    toolchain = "{impl}",
    toolchain_type = "@rules_renode//renode:toolchain_type",
    visibility = ["//visibility:public"],
)
"""

def _renode_toolchains_repository(repository_ctx):
    build_file = []
    toolchain_configs = repository_ctx.attr.toolchain_configs

    for i, toolchain_repo in enumerate(repository_ctx.attr.toolchains):
        if i < len(toolchain_configs):
            config = toolchain_configs[i]
            # config is "name:os:cpu" format
            parts = config.split(":")
            os = parts[1] if len(parts) > 1 else "linux"
            cpu = parts[2] if len(parts) > 2 else "x86_64"
        else:
            os = "linux"
            cpu = "x86_64"

        build_file.append(_RENODE_TOOLCHAIN_TEMPLATE.format(
            name = toolchain_repo,
            os = os,
            cpu = cpu,
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

dmg_renode_repository = repository_rule(
    implementation = _dmg_renode_toolchain_repository_impl,
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
        "toolchain_configs": attr.string_list(
            doc = "List of 'name:os:cpu' configs matching toolchains order",
        ),
    },
)

_download_portable = tag_class(
    doc = "Downloads a portable Renode to a repository of the passed name",
    attrs = {
        "name": attr.string(),
        "url": attr.string(),
        "sha256": attr.string(),
        "os": attr.string(doc = "Target OS: linux or macos"),
        "cpu": attr.string(doc = "Target CPU: x86_64 or aarch64"),
    },
)

_local_build = tag_class(
    doc = "Copies a locally built Renode to a repository of the passed name, it isn't hermetic",
    attrs = {
        "name": attr.string(),
        "path": attr.string(),
        "os": attr.string(doc = "Target OS: linux or macos"),
        "cpu": attr.string(doc = "Target CPU: x86_64 or aarch64"),
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
