load("@renode_robot_deps//:requirements.bzl", "all_requirements")

def _impl(ctx):
  toolchain = ctx.toolchains["@rules_renode//:toolchain_type"].renode_runtime
  toolchain_files = depset(toolchain.runtime)

  py_toolchain = ctx.toolchains["@bazel_tools//tools/python:toolchain_type"].py3_runtime

  modules = [
      "`pwd`/external/{}".format(m.replace("@", "").replace("//","/")) 
      for m in all_requirements
  ] 

  pythonpath = ":".join(modules)

  script = """\
export PYTHONNOUSERSITE=1 && \\
export PYTHONPATH={} && \\
export PATH=`pwd`/external/python_interpreter/bazel_install/bin:$PATH && \\
RENODE_CI_MODE=YES {} \\
  --renode-config $TEST_UNDECLARED_OUTPUTS_DIR/renode_config \\
  --variable elf_file:`pwd`/{elf_file} \\
  -r $TEST_UNDECLARED_OUTPUTS_DIR {robot_file}
""".format(
      pythonpath,
      toolchain.renode_test.path,
      elf_file = ctx.file.binary.path, robot_file = ctx.file.robot.short_path
      )

  wrapper = ctx.actions.declare_file('wrapper.sh')

  ctx.actions.write(
      output = wrapper,
      content = script,
  )

  runfiles = ctx.runfiles(
      files = toolchain.runtime+[ctx.file.robot, ctx.file.binary]+ctx.files.pip_reqs, 
      transitive_files=py_toolchain.files
  )

  return [
      DefaultInfo(executable = wrapper, runfiles = runfiles),
  ]

renode_test = rule(
    implementation = _impl,
    attrs = {
        "robot": attr.label(allow_single_file = True, mandatory = True),
        "binary": attr.label(allow_single_file = True, mandatory = True),
        "pip_reqs": attr.label_list(default = all_requirements, allow_files=True)
    },
    toolchains = [
        "@rules_renode//:toolchain_type",
        "@bazel_tools//tools/python:toolchain_type"
    ],
    test = True,
)
