def copy(name, src, out):
    native.genrule(
        name = name,
        srcs = [src],
        outs = [out],
        cmd = "cp $(SRCS) $@",
        message = "Copying $(SRCS)",
    )
