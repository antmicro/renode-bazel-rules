load("@rules_cc//cc:defs.bzl", "cc_library")

def tcg_library(architecture = "i386", target_word_size = "32", target_insn_start_extra_words = "1", endianess = "le"):
    defines = [
        "HOST_LONG_BITS=64",
        "TARGET_LONG_BITS=" + target_word_size,
        "TARGET_INSN_START_EXTRA_WORDS=" + target_insn_start_extra_words,
    ]
    if endianess == "be":
        defines += "TARGET_WORDS_BIGENDIAN"

    cc_library(
        name = "tcg_" + architecture + "-" + target_word_size + "-" + target_insn_start_extra_words + "_" + endianess,
        srcs = [
            "@renode_sources//:tlib-tcg-common",
            "@renode_sources//:tlib-tcg-" + architecture,
        ],
        defines = defines,
        copts = [
            "-fomit-frame-pointer",
            "-O3",
            "-fPIC",
        ],
    )
