load("@rules_python//python:defs.bzl", "py_runtime", "py_runtime_pair")
load("@renode_robot_deps//:requirements.bzl", "requirement")
package(default_visibility = ["//visibility:public"]) 

py_runtime(
    name = "python3_runtime",
    files = ["@python_interpreter//:files"],
    interpreter = "@python_interpreter//:python_bin",
    python_version = "PY3",
    visibility = ["//visibility:public"],
)

py_runtime_pair(
    name = "my_py_runtime_pair",
    py2_runtime = None,
    py3_runtime = ":python3_runtime",
)

toolchain(
    name = "my_py_toolchain",
    toolchain = ":my_py_runtime_pair",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
    visibility = ["//visibility:public"]
)
