RenodeRuntimeInfo = provider(
    fields = {
        "renode": "Path to Renode",
        "renode_test": "Path to Renode test wrapper", 
        "runtime": "All runtime files",
    }
)

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
  r = _find_tool("renode")
  rt = _find_tool("test.sh")

  return [platform_common.ToolchainInfo(
      renode_runtime = RenodeRuntimeInfo(
          renode = r,
          renode_test = rt,
          runtime = ctx.files.runtime,
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
