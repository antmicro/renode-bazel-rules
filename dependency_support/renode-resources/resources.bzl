load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def renode_resources():
   git_hash = "fc84585d8337891ef03eae703f855335faa0996e"
   archive_sha256 = "fdd4e439878728ce819e8125095515910f9e9c8531050f5646c5b1520ef4ab69"

   maybe(
       http_archive,
       name = "renode-resources",
       url = "https://github.com/renode/renode-resources/archive/%s.zip" % git_hash,
       sha256 = archive_sha256,
	   strip_prefix = "renode-resources-%s" % git_hash,
       build_file = "//dependency_support/renode-resources:BUILD",
   )
