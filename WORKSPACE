workspace(name = 'rules_renode')

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file", "http_archive")
load("//renode:deps.bzl", "renode_register_toolchain")

renode_register_toolchain()

http_file(
    name = "nxp_k64f--zephyr_basic_uart.elf",
    urls = ["https://dl.antmicro.com/projects/renode/nxp_k64f--zephyr_basic_uart.elf-s_618844-2d588c6899efaae76a7a27136fd8cff667bbcb6f"],
    sha256 = "db432c3efa414a365dc55cdbffb29ed827914d7ef2d7a605cad981a2b349042d",
)

http_archive(
    name = "python_interpreter",
    build_file_content = """
exports_files(["python_bin"])
filegroup(
    name = "files",
    srcs = glob(["bazel_install/**"], exclude = ["**/* *"]),
    visibility = ["//visibility:public"],
)
""",
    patch_cmds = [
        "mkdir $(pwd)/bazel_install",
        "./configure --prefix=$(pwd)/bazel_install",
        "make",
        "make install",
        "ln -s bazel_install/bin/python3 python_bin",
    ],
    sha256 = "dfab5ec723c218082fe3d5d7ae17ecbdebffa9a1aea4d64aa3a2ecdd2e795864",
    strip_prefix = "Python-3.8.3",
    urls = ["https://www.python.org/ftp/python/3.8.3/Python-3.8.3.tar.xz"],
)

http_archive(
    name = "rules_python",
    sha256 = "778197e26c5fbeb07ac2a2c5ae405b30f6cb7ad1f5510ea6fdac03bded96cc6f",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.2.0/rules_python-0.2.0.tar.gz",
)

load("@rules_python//python:pip.bzl", "pip_install")

pip_install(
    extra_pip_args = ["-v"],
    name = "renode_robot_deps",
    requirements = "@renode_linux_amd64//:requirements.txt",
    python_interpreter_target = "@python_interpreter//:python_bin",
    quiet = False,
)

register_toolchains("@rules_renode//renode:my_py_toolchain")

