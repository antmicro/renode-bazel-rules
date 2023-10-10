load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

package(default_visibility = ["//visibility:public"])

csharp_library(
    name = "BigGustave",
    srcs = [
     "src/BigGustave/Adam7.cs",
     "src/BigGustave/Adler32Checksum.cs",
     "src/BigGustave/ChunkHeader.cs",
     "src/BigGustave/ColorType.cs",
     "src/BigGustave/CompressionMethod.cs",
     "src/BigGustave/Crc32.cs",
     "src/BigGustave/Decoder.cs",
     "src/BigGustave/FilterMethod.cs",
     "src/BigGustave/FilterType.cs",
     "src/BigGustave/HeaderValidationResult.cs",
     "src/BigGustave/IChunkVisitor.cs",
     "src/BigGustave/ImageHeader.cs",
     "src/BigGustave/InterlaceMethod.cs",
     "src/BigGustave/Palette.cs",
     "src/BigGustave/Pixel.cs",
     "src/BigGustave/Png.cs",
     "src/BigGustave/PngBuilder.cs",
     "src/BigGustave/PngOpener.cs",
     "src/BigGustave/PngOpenerSettings.cs",
     "src/BigGustave/PngStreamWriteHelper.cs",
     "src/BigGustave/RawPngData.cs",
     "src/BigGustave/StreamHelper.cs",
    ],
    internals_visible_to = ["lib_biggustave"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [],
    defines = ["NET"],
)

