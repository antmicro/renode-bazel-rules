def _renode_download_impl(ctx):
  ctx.report_progress("Downloading Renode...")

  ctx.download_and_extract(
      ctx.attr.urls,
      sha256 = ctx.attr.sha256,
      stripPrefix = "renode_1.12.0+20210415git39ecc7c_portable"
  )

  ctx.template(
      "BUILD.bazel",
      ctx.attr._build_tpl,
      )

renode_download = repository_rule(
    implementation = _renode_download_impl,
    attrs = {
        "urls": attr.string_list(
            mandatory = True
        ),
        "sha256": attr.string(
            mandatory = True
        ),
        "_build_tpl": attr.label(
            default = "//renode/private:BUILD.dist.bazel.tpl"
        ),
    },
)
