def _find_tool(ctx, name):
    cmd = None
    for f in ctx.files.runtime:
      if f.path.endswith(name):
            cmd = f
            break
    if not cmd:
        fail("could not locate tool `%s`" % name)

    return cmd

def _renode_toolchain_impl(ctx):
    r = _find_tool(ctx, "renode")
    rt = _find_tool(ctx, "renode-test")
    rte = _find_tool(ctx, "Renode")

    return [platform_common.ToolchainInfo(
        renode_runtime = RenodeRuntimeInfo(
            renode = r,
            renode_test = rt,
            renode_executable = rte,
            runtime = ctx.files.runtime,
        ),
    )]

RenodeRuntimeInfo = provider(
    doc = "Renode integration",
    fields = {
        "renode": "Path to Renode",
        "renode_test": "Path to Renode test wrapper",
        "renode_executable": "Path to Renode executable",
        "runtime": "All runtime files",
    },
)

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
