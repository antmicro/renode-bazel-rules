load("//renode:repo.bzl", _renode_download = "renode_download")

renode_download = _renode_download

def renode_register_toolchain():
  renode_download(
      name = "renode_linux_amd64",
      sha256 = "968aa3c2f7dbb0bddb2ef7046eb48c7557c2399829c8d4eb2cb2cff7d7f94b44",
      urls = [
          "https://dl.antmicro.com/projects/renode/builds/renode-1.12.0+20210415git39ecc7c.linux-portable.tar.gz"
      ],
  )

  native.register_toolchains(
      "@renode_linux_amd64//renode:toolchain"
  )
