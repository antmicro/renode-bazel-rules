def _impl(ctx):
  script = "/opt/renode/tests/test.sh --variable mach_arg:{mach_arg} {robot_file}".format(
      mach_arg = ctx.attr.binary, robot_file = ctx.file.robot.short_path)

  ctx.actions.write(
      output = ctx.outputs.executable,
      content = script,
  )

  runfiles = ctx.runfiles(files = [ctx.file.robot])
  return [DefaultInfo(runfiles = runfiles)]

renode_test = rule(
    implementation = _impl,
    attrs = {
        "robot": attr.label(allow_single_file = True),
        "binary": attr.string(mandatory = True),
    },
    test = True,
)
