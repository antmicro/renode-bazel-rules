load("@renode_test_python_deps//:requirements.bzl", "all_requirements")

RENODE_TOOLCHAIN_TYPE = "@rules_renode//renode:toolchain_type"
PYTHON_TOOLCHAIN_TYPE = "@bazel_tools//tools/python:toolchain_type"

def _python_deps(targets):
    return [d for t in targets for d in (t[DefaultInfo].files, t[DefaultInfo].default_runfiles.files)]

def _python_paths(targets):
    imports = depset(transitive = [t[PyInfo].imports for t in targets])

    # Rules Python doesn't provide an import path of the File type.
    # We depend on Output Directory Layout.
    return ["external/" + i for i in imports.to_list()]

def _prepend_path_env(env_name, paths = []):
    if len(paths) == 0:
        return ""
    paths.append("${}".format(env_name))
    return "export {}=\"{}\"".format(env_name, ":".join(paths))

def _command_using_python_executable(ctx, command, path_prepend, pythonpath_prepend, depsets, depfiles):
    script_parts = [
        _prepend_path_env("PATH", path_prepend),
        _prepend_path_env("PYTHONPATH", pythonpath_prepend),
        command,
    ]
    wrapper = ctx.actions.declare_file(ctx.label.name + "_wrapper.sh")
    ctx.actions.write(
        output = wrapper,
        content = "\n".join(script_parts),
    )
    runfiles = ctx.runfiles(
        files = depfiles,
        transitive_files = depset(transitive = depsets),
    )
    return DefaultInfo(executable = wrapper, runfiles = runfiles)

def _renode_test_impl(ctx):
    renode_runtime = ctx.toolchains[RENODE_TOOLCHAIN_TYPE].renode_runtime
    python_runtime = ctx.toolchains[PYTHON_TOOLCHAIN_TYPE].py3_runtime
    python_deps = ctx.attr._python_deps

    depfiles = [
        ctx.file.robot_test,
    ] + ctx.files.deps

    robot_command_parts = [
        renode_runtime.renode_test.path,
        "--renode-config",
        "$TEST_TMPDIR/renode_config",
        "-r",
        "$TEST_UNDECLARED_OUTPUTS_DIR",
        ctx.file.robot_test.path,
    ]
    robot_command_parts += ctx.attr.additional_arguments

    for (name, value) in ctx.attr.variables.items():
        robot_command_parts.append("--variable")
        robot_command_parts.append("{}:{}".format(name, ctx.expand_location(value)))

    path = [python_runtime.interpreter.dirname]
    pythonpath = _python_paths(python_deps)

    depsets = [
        renode_runtime.files,
        python_runtime.files,
    ]
    depsets += _python_deps(python_deps)

    return [_command_using_python_executable(
        ctx,
        " ".join(robot_command_parts),
        path,
        pythonpath,
        depsets,
        depfiles,
    )]

renode_test = rule(
    implementation = _renode_test_impl,
    test = True,
    attrs = {
        "robot_test": attr.label(
            allow_single_file = True,
            mandatory = True,
        ),
        "deps": attr.label_list(
            allow_files = True,
            doc = "Dependencies available in the runtime",
        ),
        "variables": attr.string_dict(
            doc = "Variables passed to renode-test, location templates in values are expended",
        ),
        "additional_arguments": attr.string_list(
            doc = "Additional arguments passed to renode-test",
        ),
        "_python_deps": attr.label_list(
            default = all_requirements,
            allow_files = True,
            providers = [PyInfo],
        ),
    },
    toolchains = [
        RENODE_TOOLCHAIN_TYPE,
        PYTHON_TOOLCHAIN_TYPE,
    ],
)
