RenodeRuntimeInfo = provider(
    fields = {
        "renode": "Path to Renode",
        "renode_test": "Path to Renode test wrapper",
        "files": "All runtime files",
    },
)

def _find_tool(ctx, name):
    for file in ctx.files.runtime:
        if file.basename == name:
            return file
    fail("Could not locate tool `%s`" % name)
    return None

def _renode_toolchain_impl(ctx):
    return [platform_common.ToolchainInfo(
        renode_runtime = RenodeRuntimeInfo(
            renode = _find_tool(ctx, "renode"),
            renode_test = _find_tool(ctx, "renode-test"),
            files = depset(ctx.files.runtime),
        ),
    )]

renode_toolchain = rule(
    implementation = _renode_toolchain_impl,
    attrs = {
        "runtime": attr.label_list(
            mandatory = True,
            allow_files = True,
            cfg = "target",
        ),
    },
)
