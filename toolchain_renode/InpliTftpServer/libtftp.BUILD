load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

package(default_visibility = ["//visibility:public"])

csharp_library(
    name = "libtftp",
    srcs = [
     "libtftp/ETftpErrorType.cs",
     "libtftp/ETftpLogSeverity.cs",
     "libtftp/ETftpOperationType.cs",
     "libtftp/ETftpPacketType.cs",
     "libtftp/helpers/BufferPrimitives.cs",
     "libtftp/TftpGetStreamEventArgs.cs",
     "libtftp/TftpLogEventArgs.cs",
     "libtftp/TftpRequest.cs",
     "libtftp/TftpServer.cs",
     "libtftp/TftpSession.cs",
     "libtftp/TftpTransferCompleteEventArgs.cs",
     "libtftp/TftpTransferErrorEventArgs.cs",
    ],
    internals_visible_to = ["lib_libtftp"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [
    ],
    defines = ["NET"],
    allow_unsafe_blocks = True,
)
