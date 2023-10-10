load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

package(default_visibility = ["//visibility:public"])

csharp_library(
    name = "OptionsParser",
    srcs = [
     "Description/DelimiterAttribute.cs",
     "Description/DescriptionAttribute.cs",
     "Description/HideAttribute.cs",
     "Description/NameAttribute.cs",
     "Description/NumberOfElementsAttribute.cs",
     "Description/PositionalArgumentAttribute.cs",
     "Help/ApplicationInfo.cs",
     "Help/HelpOption.cs",
     "Parser/CommandLineOption.cs",
     "Parser/CommandLineOptionDescriptor.cs",
     "Parser/ElementDescriptor.cs",
     "Parser/IFlag.cs",
     "Parser/IParsedArgument.cs",
     "Parser/IUnexpectedArgument.cs",
     "Parser/OptionsParser.cs",
     "Parser/ParseHelper.cs",
     "Parser/ParserConfiguration.cs",
     "Parser/PositionalArgument.cs",
     "Parser/Token.cs",
     "Parser/Tokenizer.cs",
     "Parser/UnexpectedArgument.cs",
     "Properties/AssemblyInfo.cs",
     "Validation/DefaultValueAttribute.cs",
     "Validation/IValidatedOptions.cs",
     "Validation/RequiredAttribute.cs",
     "Validation/ValidationException.cs",
    ],
    internals_visible_to = ["lib_optionsparser"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [
    ],
    defines = ["NET"],
    allow_unsafe_blocks = True,
)
