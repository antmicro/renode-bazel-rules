load("@renode_test_python_deps//:requirements.bzl", "all_requirements")

RENODE_TOOLCHAIN_TYPE = "@rules_renode//renode:toolchain_type"
PYTHON_TOOLCHAIN_TYPE = "@bazel_tools//tools/python:toolchain_type"

def _python_deps(targets):
    return [d for t in targets for d in (t[DefaultInfo].files, t[DefaultInfo].default_runfiles.files)]

def _python_paths(targets):
    imports = depset(transitive = [t[PyInfo].imports for t in targets])

    # Rules Python doesn't provide an import path of the File type.
    # We depends on Output Directory Layout.
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
    wrapper = ctx.actions.declare_file("wrapper.sh")
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

    depfiles = [ctx.file.robot_test]

    robot_command_parts = [
        renode_runtime.renode_test.path,
        "--renode-config",
        "$TEST_TMPDIR/renode_config",
        "-r",
        "$TEST_UNDECLARED_OUTPUTS_DIR",
        "--show-log",
        ctx.file.robot_test.path,
    ]
    robot_command_parts += ctx.attr.additional_arguments

    variable_names = ctx.attr.files_variable_names
    file_targets = ctx.attr.files
    if len(variable_names) != len(file_targets):
        fail("Length of files_variable_names and files must be equal.")
    else: 
        for (name, target) in zip(variable_names, file_targets):
            files = target[DefaultInfo].files.to_list()
            if len(files) != 1:
                fail("It's allowed to pass only a single file to a variable, name of the variable: {}".format(name))
                continue
            file = files[0]
            robot_command_parts.append("--variable")
            robot_command_parts.append("{}:{}".format(name, file.path))
            depfiles.append(file)

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
        "files_variable_names": attr.string_list(
            doc = "Names of variables with values defined in the files attribute",
        ),
        "files": attr.label_list(
            allow_files = True,
            doc = "Files that are values of passed variables with names defined in the files_variable_names attribute",
        ),
        "additional_arguments": attr.string_list(
            doc = "Additional arguments passed to the Robot test",
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
