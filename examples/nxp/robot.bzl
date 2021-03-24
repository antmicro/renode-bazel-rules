def _impl(ctx):
  script = "pwd && tree && RENODE_CI_MODE=YES renode-test --variable elf_file:`pwd`/{elf_file} {robot_file}".format(
      elf_file = ctx.file.binary.path, robot_file = ctx.file.robot.short_path
      )

  ctx.actions.write(
      output = ctx.outputs.executable,
      content = script,
  )

  runfiles = ctx.runfiles(files = [ctx.file.robot, ctx.file.binary])
  return [DefaultInfo(runfiles = runfiles)]

renode_test = rule(
    implementation = _impl,
    attrs = {
        "robot": attr.label(allow_single_file = True, mandatory = True),
        "binary": attr.label(allow_single_file = True, mandatory = True),
    },
    test = True,
)
