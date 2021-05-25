load("//renode:repo.bzl", _renode_download = "renode_download")

renode_download = _renode_download

def renode_register_toolchain():
  renode_download(
      name = "renode_linux_amd64",
      sha256 = "d4793c211644c06b3014f761c0c302a271c974223cc8fe21e23280cee171a780", 
      urls = [
          "https://dl.antmicro.com/projects/renode/builds/renode-1.12.0+reduced_req.linux-portable.tar.gz"
      ],
  )

  native.register_toolchains(
      "@renode_linux_amd64//:toolchain"
  )
