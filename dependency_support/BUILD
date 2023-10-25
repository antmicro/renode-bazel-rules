load("@rules_python//python:pip.bzl", "compile_pip_requirements")

compile_pip_requirements(
    name = "pip_requirements",
    requirements_in = "@renode_sources//:pip_requirements",
    requirements_txt = "pip_requirements_lock.txt",
)

