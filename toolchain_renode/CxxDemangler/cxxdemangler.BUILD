load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
)

package(default_visibility = ["//visibility:public"])

csharp_library(
    name = "CxxDemangler",
    srcs = [
     "CxxDemangler/CxxDemangler.cs",
     "CxxDemangler/DemanglingContext.cs",
     "CxxDemangler/IDemangleAsInner.cs",
     "CxxDemangler/IParsingResult.cs",
     "CxxDemangler/Parsers/ArrayType.cs",
     "CxxDemangler/Parsers/BareFunctionType.cs",
     "CxxDemangler/Parsers/BaseUnresolvedName.cs",
     "CxxDemangler/Parsers/BuiltinType.cs",
     "CxxDemangler/Parsers/CallOffset.cs",
     "CxxDemangler/Parsers/ClassEnumType.cs",
     "CxxDemangler/Parsers/ClosureTypeName.cs",
     "CxxDemangler/Parsers/CtorDtorName.cs",
     "CxxDemangler/Parsers/CvQualifiers.cs",
     "CxxDemangler/Parsers/DataMemberPrefix.cs",
     "CxxDemangler/Parsers/Decltype.cs",
     "CxxDemangler/Parsers/DestructorName.cs",
     "CxxDemangler/Parsers/DictionaryParser.cs",
     "CxxDemangler/Parsers/DictionaryValueAttribute.cs",
     "CxxDemangler/Parsers/Discriminator.cs",
     "CxxDemangler/Parsers/Encoding.cs",
     "CxxDemangler/Parsers/Expression.cs",
     "CxxDemangler/Parsers/ExprPrimary.cs",
     "CxxDemangler/Parsers/FunctionParam.cs",
     "CxxDemangler/Parsers/FunctionType.cs",
     "CxxDemangler/Parsers/Initializer.cs",
     "CxxDemangler/Parsers/LambdaSig.cs",
     "CxxDemangler/Parsers/LocalName.cs",
     "CxxDemangler/Parsers/MangledName.cs",
     "CxxDemangler/Parsers/Name.cs",
     "CxxDemangler/Parsers/NestedName.cs",
     "CxxDemangler/Parsers/OperatorName.cs",
     "CxxDemangler/Parsers/PointerToMemberType.cs",
     "CxxDemangler/Parsers/Prefix.cs",
     "CxxDemangler/Parsers/RefQualifier.cs",
     "CxxDemangler/Parsers/SimpleId.cs",
     "CxxDemangler/Parsers/SimpleOperatorName.cs",
     "CxxDemangler/Parsers/SourceName.cs",
     "CxxDemangler/Parsers/SpecialName.cs",
     "CxxDemangler/Parsers/StandardBuiltinType.cs",
     "CxxDemangler/Parsers/Substitution.cs",
     "CxxDemangler/Parsers/TemplateArg.cs",
     "CxxDemangler/Parsers/TemplateArgs.cs",
     "CxxDemangler/Parsers/TemplateParam.cs",
     "CxxDemangler/Parsers/TemplateTemplateParam.cs",
     "CxxDemangler/Parsers/Type.cs",
     "CxxDemangler/Parsers/UnnamedTypeName.cs",
     "CxxDemangler/Parsers/UnqualifiedName.cs",
     "CxxDemangler/Parsers/UnresolvedName.cs",
     "CxxDemangler/Parsers/UnresolvedQualifierLevel.cs",
     "CxxDemangler/Parsers/UnresolvedType.cs",
     "CxxDemangler/Parsers/UnscopedName.cs",
     "CxxDemangler/Parsers/UnscopedTemplateName.cs",
     "CxxDemangler/Parsers/WellKnownComponent.cs",
     "CxxDemangler/ParsingContext.cs",
     "CxxDemangler/Properties/AssemblyInfo.cs",
     "CxxDemangler/SimpleStringParser.cs",
     "CxxDemangler/SimpleStringWriter.cs",
     "CxxDemangler/SubstitutionTable.cs",
    ],
    internals_visible_to = ["lib_cxxdemangler"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [],
    defines = ["NET"],
)
