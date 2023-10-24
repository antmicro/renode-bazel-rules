load("@rules_python//python:pip.bzl", "pip_parse")
load("@python311//:defs.bzl", python_interpreter_target = "interpreter")

def initialize_external_repositories():
    pip_parse(
        name = "renode_pip_deps",
        requirements_lock = "@com_antmicro_renode//dependency_support:pip_requirements_lock.txt",
        python_interpreter = python_interpreter_target,
    )

