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

def _get_runfiles_init():
    return """
# --- begin runfiles.bash initialization v3 ---
# Copy-pasted from the Bazel Bash runfiles library v3.
set -uo pipefail; set +e; f=bazel_tools/tools/bash/runfiles/runfiles.bash
# shellcheck disable=SC1090
source "${RUNFILES_DIR:-/dev/null}/$f" 2>/dev/null || \
source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-/dev/null}" | cut -f2- -d' ')" 2>/dev/null || \
source "$0.runfiles/$f" 2>/dev/null || \
source "$(grep -sm1 "^$f " "$0.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
source "$(grep -sm1 "^$f " "$0.exe.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
{ echo>&2 "ERROR: cannot find $f"; exit 1; }; f=; set -e
# --- end runfiles.bash initialization v3 ---
"""

def _command_using_python_executable(ctx, command, path_prepend, pythonpath_prepend, depsets, depfiles):
    script_parts = [
        _prepend_path_env("PATH", path_prepend),
        _prepend_path_env("PYTHONPATH", pythonpath_prepend),
        "export HOME=$TEST_TMPDIR",
        _get_runfiles_init(),
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

def _rlocationpath_str(ctx, label, target):
    return ctx.expand_location("$(rlocationpath {})".format(label), targets = [target])

def _parse_file_variables_with_label(ctx, depsets, variables_with_label):
    names_and_rlocations = []
    for (name, label) in variables_with_label.items():
        if len(label.files.to_list()) != 1:
            fail("The {} target must contains only a single file".format(name))

        depsets.append(label.default_runfiles.files)
        rlocation = _rlocationpath_str(ctx, label.label, label)
        names_and_rlocations.append((name, rlocation))
    return names_and_rlocations

def _renode_test_impl(ctx):
    renode_runtime = ctx.toolchains[RENODE_TOOLCHAIN_TYPE].renode_runtime
    python_runtime = ctx.toolchains[PYTHON_TOOLCHAIN_TYPE].py3_runtime
    python_deps = ctx.attr._python_deps

    depfiles = [
        ctx.file.robot_test,
    ] + ctx.files.deps + ctx.files._bash_runfiles
    depsets = [
        renode_runtime.files,
        python_runtime.files,
    ]

    robot_command_parts = [
        renode_runtime.renode_test.path,
        "--renode-config",
        "$TEST_TMPDIR/renode_config",
        "-r",
        "$TEST_UNDECLARED_OUTPUTS_DIR",
        ctx.file.robot_test.path,
    ]
    robot_command_parts += ctx.attr.additional_arguments

    for (name, rlocation) in _parse_file_variables_with_label(
        ctx,
        depsets,
        ctx.attr.variables_with_label,
    ):
        robot_command_parts.append("--variable")
        robot_command_parts.append("{}:`rlocation {}`".format(name, rlocation))

    depfiles += ctx.files.variables_with_label

    path = [python_runtime.interpreter.dirname]
    pythonpath = _python_paths(python_deps)

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
        "variables_with_label": attr.string_keyed_label_dict(
            doc = "Variables containing Label or File passed to the Robot test",
            allow_files = True,
        ),
        "additional_arguments": attr.string_list(
            doc = "Additional arguments passed to renode-test",
        ),
        "_python_deps": attr.label_list(
            default = all_requirements,
            allow_files = True,
            providers = [PyInfo],
        ),
        "_bash_runfiles": attr.label(
            default = Label("@bazel_tools//tools/bash/runfiles"),
            allow_single_file = True,
        ),
    },
    toolchains = [
        RENODE_TOOLCHAIN_TYPE,
        PYTHON_TOOLCHAIN_TYPE,
    ],
)

def _renode_interactive_impl(ctx):
    renode_runtime = ctx.toolchains[RENODE_TOOLCHAIN_TYPE].renode_runtime
    depfiles = ctx.files.deps + ctx.files.variables_with_label + ctx.files._bash_runfiles
    depsets = [renode_runtime.files]

    # Assemble the command
    script_parts = [renode_runtime.renode.path]
    script_parts += ctx.attr.arguments

    for (name, rlocation) in _parse_file_variables_with_label(
        ctx,
        depsets,
        ctx.attr.variables_with_label,
    ):
        script_parts.append("-e \\${}=\\\"`rlocation {}`\\\"".format(name, rlocation))

    for (name, value) in ctx.attr.variables.items():
        # Delibarately don't encase this in quotes to prevent Renode from interpreting the variable as a string.
        # In case of variables containing whitespaces, it's up to the end-user to escape/quote them.
        script_parts.append("-e \\${}={}".format(name, value))

    if ctx.file.resc:
        depfiles.append(ctx.file.resc)
        script_parts.append("-e \"i @" + ctx.file.resc.path + "\"")

    wrapper = ctx.actions.declare_file(ctx.label.name + "_wrapper.sh")

    # Initialization steps go here (e.g runfiles init, required for rlocation)
    script_init = _get_runfiles_init()

    ctx.actions.write(
        output = wrapper,
        content = script_init + " ".join(script_parts),
    )
    runfiles = ctx.runfiles(
        files = depfiles,
        transitive_files = depset(transitive = depsets),
    )

    return DefaultInfo(executable = wrapper, runfiles = runfiles)

renode_interactive = rule(
    implementation = _renode_interactive_impl,
    executable = True,
    attrs = {
        "resc": attr.label(
            allow_single_file = True,
        ),
        "arguments": attr.string_list(
            doc = "Arguments passed to Renode",
        ),
        "deps": attr.label_list(
            allow_files = True,
            doc = "Dependencies available in the runtime",
        ),
        "variables_with_label": attr.string_keyed_label_dict(
            doc = "Variables containing Label or File that need to be expanded by Bazel",
            allow_files = True,
        ),
        "variables": attr.string_dict(
            doc = "Variables passed to Renode. Quotation is needed if they contain whitespaces",
        ),
        "_bash_runfiles": attr.label(
            default = Label("@bazel_tools//tools/bash/runfiles"),
            allow_single_file = True,
        ),
    },
    toolchains = [
        RENODE_TOOLCHAIN_TYPE,
    ],
)
