load("@renode_robot_deps//:requirements.bzl", "requirement")

def renode_test_impl(ctx):
    toolchain = ctx.toolchains["@toolchain_renode//:toolchain_type"].renode_runtime
    toolchain_files = depset(toolchain.runtime)

    py_toolchain = ctx.toolchains["@bazel_tools//tools/python:toolchain_type"].py3_runtime

    wrapper = ctx.actions.declare_file('wrapper.sh')

    script = "RENODE_CI_MODE=YES {} \
--runner net \
--renode-config $TEST_UNDECLARED_OUTPUTS_DIR/renode_config \
--robot-framework-remote-server-directory-prefix $(cd $(dirname $0); echo $PWD)/../../external/toolchain_renode/output/bin/ \
--css-file $TEST_SRCDIR/toolchain_renode/lib/resources/styles/robot.css \
{} \
-r $TEST_UNDECLARED_OUTPUTS_DIR {}".format(
        toolchain.renode_test.path,
        "--variable elf_file:`pwd`/{elf_file}".format(elf_file = ctx.file.binary.path) if ctx.file.binary else "",
        " ".join([file.short_path for file in ctx.files.robot])
    )

    ctx.actions.write(
        output = wrapper,
        content = script,
    )

    runfiles = ctx.runfiles(
        files = toolchain.runtime + ctx.files.robot + ctx.files.binary,
        transitive_files=py_toolchain.files,
        symlinks = {
            "external/toolchain_renode/output/bin/Release/Renode.exe": toolchain.renode_executable,
        }
    ).merge_all(
      [dep.default_runfiles for dep in ctx.attr._default_reqs] +
      [dep.default_runfiles for dep in ctx.attr.pip_reqs]
    )

    modules_roots = [
        "./" + repo.label.workspace_root + "/" + repo.label.package
        for repo in (ctx.attr.pip_reqs + ctx.attr._default_reqs)
    ]
    pypath = ":".join([str(p) for p in modules_roots])
    env = {
        "PYTHONNOUSERSITE": "1",
        "PYTHONPATH" : pypath,
    }

    return [
        DefaultInfo(executable = wrapper, runfiles = runfiles),
        testing.TestEnvironment(env),
    ]



renode_test = rule(
    implementation = renode_test_impl,
    attrs = {
        "robot": attr.label_list(allow_empty = False, mandatory = True, allow_files=True),
        "binary": attr.label(allow_single_file = True),
        "pip_reqs": attr.label_list(default = [], allow_files=True),
        "_default_reqs": attr.label_list(default = [
            requirement("robotframework"),
            requirement("requests"),
            requirement("psutil"),
            requirement("pyyaml"),
        ]),
    },
    toolchains = [
        "@toolchain_renode//:toolchain_type",
        "@bazel_tools//tools/python:toolchain_type",
    ],
    test = True,
)
