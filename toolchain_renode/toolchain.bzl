
def _renode_toolchain_impl(ctx):
    r = "bazel-out/k8-fastbuild-ST-19c30ace4401/bin/external/toolchain_renode/bazelout/net6.0/Renode.dll.sh.runfiles/__main__/external/toolchain_renode/bazelout/net6.0/Renode"
    rt = ""

    return [platform_common.ToolchainInfo(
        renode_runtime = RenodeRuntimeInfo(
            renode = r,
            renode_test = rt,
        ),
    )]

RenodeRuntimeInfo = provider(
    doc = "Renode integration",
    fields = {
        "renode": "Path to Renode",
        "renode_test": "Path to Renode test wrapper",
        "runtime": "All runtime files",
    },
)

renode_toolchain = rule(
    implementation = _renode_toolchain_impl,
)
