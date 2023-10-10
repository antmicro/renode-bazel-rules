load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

package(default_visibility = ["//visibility:public"])

csharp_library(
    name = "TermSharp",
    srcs = [
     "LayoutParameters.cs",
     "ILayoutParameters.cs",
     "Terminal.cs",
     "SelectionMode.cs",
     "SelectionDirection.cs",
     "Cursor.cs",
     "Rows/MonospaceTextRow.cs",
     "Vt100/IDecoderLogger.cs",
     "Vt100/ConsoleDecoderLogger.cs",
     "Vt100/Decoder.cs",
     "Vt100/Encoder.cs",
     "Vt100/DecoderCommands.cs",
     "Vt100/ControlByte.cs",
     "Vt100/Vt100ITermFileEscapeCodeHandler.cs",
     "Misc/SimpleCache.cs",
     "Misc/Utilities.cs",
     "Rows/IRow.cs",
     "Misc/IntegerPosition.cs",
     "Misc/ClipboardData.cs",
     "Vt100/ByteUtf8Decoder.cs",
     "Misc/IGenerationAware.cs",
     "Rows/ImageRow.cs",
     "Rows/RowUtils.cs",
    ],
    internals_visible_to = ["lib_termsharp"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [
        "@Xwt//:Xwt",
    ],
    defines = ["NET"],
)

