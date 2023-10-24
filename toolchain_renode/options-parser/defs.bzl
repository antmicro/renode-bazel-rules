load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def install_optionsparser():
    git_repository(
        name = "OptionsParser",
        commit = "e355d693da106324388343fdc99c6ebcf7b03b18",
        remote = "https://github.com/antmicro/options-parser",
        build_file = "//toolchain_renode/options-parser:optionsparser.BUILD",
    )
