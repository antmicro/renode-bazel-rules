def _impl(ctx):
  script = "RENODE_CI_MODE=YES renode-test --renode-config $TEST_UNDECLARED_OUTPUTS_DIR/renode_config --variable elf_file:`pwd`/{elf_file} -r $TEST_UNDECLARED_OUTPUTS_DIR {robot_file}".format(
      elf_file = ctx.file.binary.path, robot_file = ctx.file.robot.short_path
      )

  wrapper = ctx.actions.declare_file('wrapper.sh')

  ctx.actions.write(
      output = wrapper,
      content = script,
  )

  runfiles = ctx.runfiles(files = [ctx.file.robot, ctx.file.binary])

  return [
      DefaultInfo(executable = wrapper, runfiles = runfiles),
  ]

renode_test = rule(
    implementation = _impl,
    attrs = {
        "robot": attr.label(allow_single_file = True, mandatory = True),
        "binary": attr.label(allow_single_file = True, mandatory = True),
    },
    test = True,
)
