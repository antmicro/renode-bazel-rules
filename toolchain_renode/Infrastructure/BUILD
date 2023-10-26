load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "tcg",
    srcs = [
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/tcg.c",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/tcg-runtime.c",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/optimize.c",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/additional.c",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/host-utils.c",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/tcg-op-gvec.c",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/tcg-op-vec.c",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/tcg-runtime-gvec.c",
    ],
    hdrs = [
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/tcg.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/tcg-runtime.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/additional.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/host-utils.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/tcg-op-gvec.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/bswap.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/tcg-op.h",
        #TODO: make target as a variable
        # there is also arm
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/i386/tcg-target.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/i386/tcg-target.c",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/tcg-memop.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/tcg-opc.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/tcg-gvec-desc.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/include/bit_helper.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/include/infrastructure.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/include/osdep.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/include/callbacks.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/include/def-helper.h",
    ],
    defines = [
        "HOST_LONG_BITS=64",
        "TARGET_INSN_START_EXTRA_WORDS=1",
        "TARGET_LONG_BITS=32",
    ],
    copts = [
        "-fomit-frame-pointer",
        "-O3",
        "-fPIC",
    ],
    includes = [
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg",
        #TODO: make target as a variable
        # there is also arm
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/i386",
           "src/Infrastructure/src/Emulator/Cores/tlib/include",
    ],
)

filegroup(
    name = "translate_sources",
    srcs = glob([
           "src/Infrastructure/src/Emulator/Cores/tlib/*.c",
           "src/Infrastructure/src/Emulator/Cores/tlib/arch/*.c",
           "src/Infrastructure/src/Emulator/Cores/tlib/external/*.c",
           "src/Infrastructure/src/Emulator/Cores/tlib/fpu/*.c",
           "src/Infrastructure/src/Emulator/Cores/tlib/arch/arm/*.c",
           "src/Infrastructure/src/Emulator/Cores/renode/*.c",
           "src/Infrastructure/src/Emulator/Cores/renode/arch/arm/*.c",
    ]),
)

filegroup(
    name = "translate_headers",
    srcs = glob([
           "src/Infrastructure/src/Emulator/Cores/tlib/*.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/arch/*.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/external/*.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/fpu/*.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/arch/arm/*.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/include/*.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/*.h",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/arm/*.h",
           "src/Infrastructure/src/Emulator/Cores/renode/*.h",
           "src/Infrastructure/src/Emulator/Cores/renode/include/*.h",
           "src/Infrastructure/src/Emulator/Cores/renode/arm/*.h",
    ]),
)

#TODO: csharp_library resources doesn't allow to rename libraries
# we are creating here binary, but it is in fact library
# remove this hack, when csharp_library resources will allow to rename resources
cc_binary(
    name = "translate-arm-m-le.so",
    linkshared = True,
    srcs = [
        "//:translate_sources",
        "//:translate_headers",
    ],
    #hdrs = [
    #],
    deps = [
        "//:tcg",
    ],
    defines = [
        "HOST_BITS_64",
        "HOST_I386=1",
        "HOST_LONG_BITS=64",
        "TARGET_ARM=1",
        "TARGET_INSN_START_EXTRA_WORDS=1",
        "TARGET_INT_ALIGNMENT=4",
        "TARGET_LLONG_ALIGNMENT=4",
        "TARGET_LONG_ALIGNMENT=4",
        "TARGET_LONG_BITS=32",
        "TARGET_SHORT_ALIGNMENT=2",
        "TCG_TARGET_I386",
        "TARGET_PROTO_ARM_M=1",
    ],
    copts = [
        "-fomit-frame-pointer",
        "-O3",
        "-fPIC",
        "-Wall",
        "-Wextra",
        "-Werror",
        "-Wno-unused-parameter",
        "-Wno-sign-compare",
    ],
    includes = [
           "src/Infrastructure/src/Emulator/Cores/tlib/arch/arm",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg/i386",
           "src/Infrastructure/src/Emulator/Cores/tlib/include",
           "src/Infrastructure/src/Emulator/Cores/tlib/fpu",
           "src/Infrastructure/src/Emulator/Cores/tlib/tcg",
           "src/Infrastructure/src/Emulator/Cores/renode/include",
    ],
    linkopts = [
        "-Wl,--wrap=memcpy",
        "-zdefs",
        "-lpthread",
    ],
)
