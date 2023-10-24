load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

def install_cxxdemangler():
    git_repository(
        name = "CxxDemangler",
        commit = "bfbfa181fb0768bd8da560882071113a56975274",
        remote = "https://github.com/antmicro/CxxDemangler",
        build_file = "//toolchain_renode/CxxDemangler:cxxdemangler.BUILD",
        patch_args = ["-p1"],
        patches = [
            "@//toolchain_renode/CxxDemangler:Set-AssemblyVersion.patch",
        ],
    )
