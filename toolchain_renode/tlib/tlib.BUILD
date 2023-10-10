package(default_visibility = ["//visibility:public"])

cc_library(
    name = "tcg",
    srcs = [
        "tcg/tcg.c",
        "tcg/tcg-runtime.c",
        "tcg/optimize.c",
        "tcg/additional.c",
        "tcg/host-utils.c",
        "tcg/tcg-op-gvec.c",
        "tcg/tcg-op-vec.c",
        "tcg/tcg-runtime-gvec.c",
    ],
    hdrs = [
        "tcg/tcg.h",
        "tcg/tcg-runtime.h",
        "tcg/additional.h",
        "tcg/host-utils.h",
        "tcg/tcg-op-gvec.h",
        "tcg/bswap.h",
        "tcg/tcg-op.h",
        #TODO: make target as a variable
        # there is also arm
        "tcg/i386/tcg-target.h",
        "tcg/i386/tcg-target.c",
        "tcg/tcg-memop.h",
        "tcg/tcg-opc.h",
        "tcg/tcg-gvec-desc.h",
        "include/bit_helper.h",
        "include/infrastructure.h",
        "include/osdep.h",
        "include/callbacks.h",
        "include/def-helper.h",
    ],
    defines = [
        "HOST_LONG_BITS=64",
        "TARGET_LONG_BITS=32",
        "TARGET_INSN_START_EXTRA_WORDS=1",
    ],
    copts = [
        "-fomit-frame-pointer",
        "-O3",
        "-fPIC",
    ],
    includes = [
        "tcg",
        #TODO: make target as a variable
        # there is also arm
        "tcg/i386",
        "include",
    ],
)

filegroup(
    name = "translate_sources",
    srcs = glob([
        "*.c",
        "arch/*.c",
        "external/*.c",
        "fpu/*.c",
        "arch/arm/*.c",
        "renode/*.c",
        "renode/arm/*.c",
    ]),
)

filegroup(
    name = "translate_headers",
    srcs = glob([
        "*.h",
        "arch/*.h",
        "external/*.h",
        "fpu/*.h",
        "arch/arm/*.h",
        "renode/*.h",
        "renode/arm/*.h",
        "include/*.h",
        "tcg/*.h",
        "tcg/arm/*.h",
    ]),
)

cc_library(
    name = "translate",
    srcs = [
        "//:translate_sources",
    ],
    hdrs = [
        "//:translate_headers",
    ],
    defines = [
        "CONFIG_NEED_MMU",
        "TCG_TARGET_I386",
        "HOST_BITS_64",
        "TARGET_SHORT_ALIGNMENT=2",
        "TARGET_INT_ALIGNMENT=4",
        "TARGET_LONG_ALIGNMENT=4",
        "TARGET_LLONG_ALIGNMENT=4",
        "HOST_I386=1",
        "HOST_LONG_BITS=64",
        "TARGET_ARCH=\"arm\"",
        "TARGET_ARM=1",
        "CONFIG_I386_DIS=1",
        "CONFIG_ARM_DIS=1",
        "TARGET_LONG_BITS=32",
        "TARGET_INSN_START_EXTRA_WORDS=1",
        "TARGET_PROTO_ARM_M=1",
    ],
    copts = [
        "-fomit-frame-pointer",
        "-O3",
        "-fPIC",
        "-Wall",
        "-Wextra",
        "-Wno-unused-parameter",
        "-Wno-sign-compare",
    ],
    includes = [
        "arch/arm",
        "tcg/arm",
        "include",
        "fpu",
        "tcg",
        "renode/include",
    ],
)
