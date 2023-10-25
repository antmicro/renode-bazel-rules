load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def load_renode_sources():
    renode_version = "1.14.0"
    archive_sha256 = "0de44db355a26d49ff66665765b97d2346daa1233a59f0468bc6e117c750036e"

    maybe(
        http_archive,
        name = "renode_sources",
        url = "https://github.com/renode/renode/releases/download/v%s/renode_%s_source.tar.xz" % (renode_version, renode_version),
        sha256 = archive_sha256,
        strip_prefix = "renode_%s_source" % renode_version,
        build_file = "//renode_sources:BUILD",
    )

