load("@//toolchain_renode:toolchain.bzl", "renode_toolchain")
load("@//toolchain_renode:copy.bzl", "copy")
package(default_visibility = ["//visibility:public"])

toolchain_type(
    name = "toolchain_type",
    visibility = ["//visibility:public"],
)

copy(
    name = "copy_styles_robot",
    src = "@renode-resources//:robot-style",
    out = "lib/resources/styles/robot.css",
)

filegroup(
    name = "platforms",
    srcs = glob(["platforms/**/*"]),
)

filegroup(
    name = "scripts",
    srcs = glob(["scripts/**/*"]),
)

# tools contains executable files that are part of the toolchain.
filegroup(
    name = "runtime",
    srcs = [
        "renode",
        "renode-test",
        "tools/common.sh",
        "tests/run_tests.py",
        "tests/tests.yaml",
        ".renode-root",
        "//:platforms",
        "//:scripts",
        "//:copy_styles_robot",
        "//:publish_renode",
    ]
)

# toolchain_impl gathers information about the Renode toolchain.
# See the RenodeToolchain provider.
renode_toolchain(
    name = "toolchain_impl",
    runtime = [":runtime"],
)

# This target should be registered by
# calling register_toolchains in a WORKSPACE file.
toolchain(
    name = "toolchain",
    toolchain = ":toolchain_impl",
    toolchain_type = "//:toolchain_type",
)

load(
    "@rules_dotnet//dotnet:defs.bzl",
    "csharp_library",
    "csharp_binary",
    "publish_binary",
)
csharp_library(
    name = "VerilatorPlugin",
    srcs = [
     "src/Plugins/VerilatorPlugin/Connection/IVerilatedPeripheral.cs",
     "src/Plugins/VerilatorPlugin/Connection/LibraryVerilatorConnection.cs",
     "src/Plugins/VerilatorPlugin/Connection/Protocols/ActionType.cs",
     "src/Plugins/VerilatorPlugin/Connection/Protocols/ProtocolMessage.cs",
     "src/Plugins/VerilatorPlugin/Connection/SocketVerilatorConnection.cs",
     "src/Plugins/VerilatorPlugin/Verilated/Peripherals/BaseDoubleWordVerilatedPeripheral.cs",
     "src/Plugins/VerilatorPlugin/Verilated/Peripherals/BaseVerilatedPeripheral.cs",
     "src/Plugins/VerilatorPlugin/Verilated/Peripherals/CFUVerilatedPeripheral.cs",
     "src/Plugins/VerilatorPlugin/Verilated/Peripherals/VerilatedCPU.cs",
     "src/Plugins/VerilatorPlugin/Verilated/Peripherals/VerilatedPeripheral.cs",
     "src/Plugins/VerilatorPlugin/Verilated/Peripherals/VerilatedRiscV32.cs",
     "src/Plugins/VerilatorPlugin/Verilated/Peripherals/VerilatedRiscV32Registers.cs",
     "src/Plugins/VerilatorPlugin/Verilated/Peripherals/VerilatedUART.cs",
     "src/Plugins/VerilatorPlugin/VerilatorPlugin.cs",
    ],
    internals_visible_to = ["lib_verilatorplugin"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [
        "@RenodeInfrastructure//:Emulator",
        "@RenodeInfrastructure//:Extensions",
        "@RenodeInfrastructure//:Renode-peripherals",
        "@RenodeInfrastructure//:cores-riscv",
        "@Migrant//:Migrant",
        "@ELFSharp//:ELFSharp",
        "@PacketDotNet//:PacketDotNet",
        "@CxxDemangler//:CxxDemangler",
        "@AntShell//:AntShell",
        "@Xwt//:Xwt",
        "@BigGustave//:BigGustave",
        "@Xwt//:XwtGtk",
        "@termsharp//:TermSharp",
        "@renode-resources//:lucene",
        "@renode-resources//:IronPython",
        "@renode-resources//:IronPythonStdLib",
        "@renode-resources//:IronPythonModules",
        "@renode-resources//:MicrosoftScripting",
        "@renode-resources//:MonoLinqExpressions",
        "@renode-resources//:MonoTextTemplating",
        "@resources//dynamitey",
        "@resources//system.drawing.common",
        "@resources//gtksharp",
        "@resources//atksharp",
        "@resources//glibsharp",
        "@resources//cairosharp",
        "@resources//gdksharp",
        "@resources//giosharp",
        "@resources//pangosharp",
        "@resources//mono.posix.netstandard",
        "@resources//microsoft.codeanalysis.csharp",
        "@resources//microsoft.codeanalysis.visualbasic",
        "@resources//microsoft.codeanalysis.common",
        "@resources//microsoft.codeanalysis.analyzers",
        "@resources//system.codedom",
        "@resources//system.configuration.configurationmanager",
        "@resources//mono.cecil",
    ],
    defines = ["NET"],
    allow_unsafe_blocks = True,
)

csharp_library(
    name = "WiresharkPlugin",
    srcs = [
     "src/Plugins/WiresharkPlugin/BLESniffer.cs",
     "src/Plugins/WiresharkPlugin/INetworkLogExtensions.cs",
     "src/Plugins/WiresharkPlugin/LinkLayer.cs",
     "src/Plugins/WiresharkPlugin/Wireshark.cs",
     "src/Plugins/WiresharkPlugin/WiresharkPlugin.cs",
     "src/Plugins/WiresharkPlugin/WiresharkSender.cs",
    ],
    internals_visible_to = ["lib_wiresharkplugin"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [
        "@RenodeInfrastructure//:Emulator",
        "@RenodeInfrastructure//:Extensions",
        "@Migrant//:Migrant",
        "@ELFSharp//:ELFSharp",
        "@PacketDotNet//:PacketDotNet",
        "@CxxDemangler//:CxxDemangler",
        "@AntShell//:AntShell",
        "@Xwt//:Xwt",
        "@BigGustave//:BigGustave",
        "@Xwt//:XwtGtk",
        "@termsharp//:TermSharp",
        "@renode-resources//:lucene",
        "@renode-resources//:IronPython",
        "@renode-resources//:IronPythonStdLib",
        "@renode-resources//:IronPythonModules",
        "@renode-resources//:MicrosoftScripting",
        "@renode-resources//:MonoLinqExpressions",
        "@renode-resources//:MonoTextTemplating",
        "@resources//dynamitey",
        "@resources//system.drawing.common",
        "@resources//gtksharp",
        "@resources//atksharp",
        "@resources//glibsharp",
        "@resources//cairosharp",
        "@resources//gdksharp",
        "@resources//giosharp",
        "@resources//pangosharp",
        "@resources//mono.posix.netstandard",
        "@resources//microsoft.codeanalysis.csharp",
        "@resources//microsoft.codeanalysis.visualbasic",
        "@resources//microsoft.codeanalysis.common",
        "@resources//microsoft.codeanalysis.analyzers",
        "@resources//system.codedom",
        "@resources//system.configuration.configurationmanager",
        "@resources//mono.cecil",
    ],
    defines = ["NET"],
    allow_unsafe_blocks = True,
)

csharp_binary(
    name = "Renode",
    srcs = [
      "src/Renode/Backends/Terminals/UartPtyTerminal.cs",
      "src/Renode/Connectors/GPIOConnector.cs",
      "src/Renode/EmulationEnvironment/EmulationEnvironment.cs",
      "src/Renode/Integrations/ArduinoLoader.cs",
      "src/Renode/Integrations/AsciinemaRecorder.cs",
      "src/Renode/Network/NetworkServer/IServerModule.cs",
      "src/Renode/Network/NetworkServer/Modules/TftpServerModule.cs",
      "src/Renode/Network/NetworkServer/NetworkServer.cs",
      "src/Renode/Network/RangeLossMediumFunction.cs",
      "src/Renode/Network/RangeMediumFunction.cs",
      "src/Renode/PlatformDescription/ConversionResult.cs",
      "src/Renode/PlatformDescription/ConversionResultType.cs",
      "src/Renode/PlatformDescription/CreationDriver.cs",
      "src/Renode/PlatformDescription/DeclarationPlace.cs",
      "src/Renode/PlatformDescription/FakeInitHandler.cs",
      "src/Renode/PlatformDescription/IInitHandler.cs",
      "src/Renode/PlatformDescription/IUsingResolver.cs",
      "src/Renode/PlatformDescription/ParsingError.cs",
      "src/Renode/PlatformDescription/ParsingException.cs",
      "src/Renode/PlatformDescription/PreLexer.cs",
      "src/Renode/PlatformDescription/SerializationProvider.cs",
      "src/Renode/PlatformDescription/Syntax/Attribute.cs",
      "src/Renode/PlatformDescription/Syntax/BoolValue.cs",
      "src/Renode/PlatformDescription/Syntax/ConstructorOrPropertyAttribute.cs",
      "src/Renode/PlatformDescription/Syntax/Description.cs",
      "src/Renode/PlatformDescription/Syntax/EmptyValue.cs",
      "src/Renode/PlatformDescription/Syntax/Entry.cs",
      "src/Renode/PlatformDescription/Syntax/EnumValue.cs",
      "src/Renode/PlatformDescription/Syntax/Grammar.cs",
      "src/Renode/PlatformDescription/Syntax/IInitable.cs",
      "src/Renode/PlatformDescription/Syntax/InitAttribute.cs",
      "src/Renode/PlatformDescription/Syntax/IPrefixable.cs",
      "src/Renode/PlatformDescription/Syntax/IrqAttribute.cs",
      "src/Renode/PlatformDescription/Syntax/IrqDestinations.cs",
      "src/Renode/PlatformDescription/Syntax/IrqEnd.cs",
      "src/Renode/PlatformDescription/Syntax/IrqReceiver.cs",
      "src/Renode/PlatformDescription/Syntax/ISimplestValue.cs",
      "src/Renode/PlatformDescription/Syntax/IVisitable.cs",
      "src/Renode/PlatformDescription/Syntax/IWithPosition.cs",
      "src/Renode/PlatformDescription/Syntax/NumericalValue.cs",
      "src/Renode/PlatformDescription/Syntax/ObjectValue.cs",
      "src/Renode/PlatformDescription/Syntax/RangeValue.cs",
      "src/Renode/PlatformDescription/Syntax/ReferenceValue.cs",
      "src/Renode/PlatformDescription/Syntax/RegistrationInfo.cs",
      "src/Renode/PlatformDescription/Syntax/SingleOrMultiIrqEnd.cs",
      "src/Renode/PlatformDescription/Syntax/StringValue.cs",
      "src/Renode/PlatformDescription/Syntax/StringWithPosition.cs",
      "src/Renode/PlatformDescription/Syntax/SyntaxTreeHelpers.cs",
      "src/Renode/PlatformDescription/Syntax/UsingEntry.cs",
      "src/Renode/PlatformDescription/Syntax/Value.cs",
      "src/Renode/PlatformDescription/UserInterface/MonitorInitHandler.cs",
      "src/Renode/PlatformDescription/UserInterface/PlatformDescriptionMachineExtensions.cs",
      "src/Renode/PlatformDescription/Variable.cs",
      "src/Renode/PlatformDescription/VariableStore.cs",
      "src/Renode/Program.cs",
      "src/Renode/RobotFrameworkEngine/CpuKeywords.cs",
      "src/Renode/RobotFrameworkEngine/HelperExtensions.cs",
      "src/Renode/RobotFrameworkEngine/HotSpotAction.cs",
      "src/Renode/RobotFrameworkEngine/HttpServer.cs",
      "src/Renode/RobotFrameworkEngine/IRobotFrameworkKeywordProvider.cs",
      "src/Renode/RobotFrameworkEngine/Keyword.cs",
      "src/Renode/RobotFrameworkEngine/KeywordException.cs",
      "src/Renode/RobotFrameworkEngine/KeywordManager.cs",
      "src/Renode/RobotFrameworkEngine/LedKeywords.cs",
      "src/Renode/RobotFrameworkEngine/LogTester.cs",
      "src/Renode/RobotFrameworkEngine/NetworkInterfaceKeywords.cs",
      "src/Renode/RobotFrameworkEngine/Recorder.cs",
      "src/Renode/RobotFrameworkEngine/RenodeKeywords.cs",
      "src/Renode/RobotFrameworkEngine/RobotFrameworkEngine.cs",
      "src/Renode/RobotFrameworkEngine/RobotFrameworkKeywordAttribute.cs",
      "src/Renode/RobotFrameworkEngine/TestersProvider.cs",
      "src/Renode/RobotFrameworkEngine/UartKeywords.cs",
      "src/Renode/RobotFrameworkEngine/XmlRpcServer.cs",
      "src/Renode/UI/LogoRow.cs",
      "src/Renode/UI/TerminalActions.cs",
      "src/Renode/UI/TerminalIOSource.cs",
      "src/Renode/UI/TerminalWidget.cs",
      "src/Renode/UI/TermsharpProvider.cs",
    ],
    internals_visible_to = ["//visibility:public"],
    target_frameworks = ["net6.0"],
    targeting_packs = [
        "@rules_dotnet_nuget_packages//microsoft.netcore.app.ref",
    ],
    deps = [
        "@RenodeInfrastructure//:Emulator",
        "@RenodeInfrastructure//:Extensions",
        "@RenodeInfrastructure//:Renode-peripherals",
        "@RenodeInfrastructure//:cores-arm",
        "@RenodeInfrastructure//:cores-arm-m",
        "@RenodeInfrastructure//:cores-arm64",
        "@RenodeInfrastructure//:cores-i386",
        "@RenodeInfrastructure//:cores-ppc",
        "@RenodeInfrastructure//:cores-ppc64",
        "@RenodeInfrastructure//:cores-riscv",
        "@RenodeInfrastructure//:cores-riscv64",
        "@RenodeInfrastructure//:cores-sparc",
        "@RenodeInfrastructure//:cores-xtensa",
        "@RenodeInfrastructure//:UI",
        "@RenodeInfrastructure//:AdvancedLoggerViewerPlugin",
        "@RenodeInfrastructure//:SampleCommandPlugin",
        "@RenodeInfrastructure//:TracePlugin",
        "//:VerilatorPlugin",
        "//:WiresharkPlugin",
        "@Migrant//:Migrant",
        "@ELFSharp//:ELFSharp",
        "@PacketDotNet//:PacketDotNet",
        "@CxxDemangler//:CxxDemangler",
        "@AntShell//:AntShell",
        "@Xwt//:Xwt",
        "@BigGustave//:BigGustave",
        "@Xwt//:XwtGtk",
        "@termsharp//:TermSharp",
        "@libtftp//:libtftp",
        "@OptionsParser//:OptionsParser",
        "@FdtSharp//:FdtSharp",
        "@crypto//:crypto",
        "@renode-resources//:MicrosoftScripting",
        "@renode-resources//:MonoLinqExpressions",
        "@renode-resources//:MonoTextTemplating",
        "@resources//dynamitey",
        "@renode-resources//:Sprache",
        "@renode-resources//:CookComputingXmlRpcV2",
        "@renode-resources//:MicrosoftDynamic",
        "@resources//system.drawing.common",
        "@resources//gtksharp",
        "@resources//atksharp",
        "@resources//glibsharp",
        "@resources//cairosharp",
        "@resources//gdksharp",
        "@resources//giosharp",
        "@resources//pangosharp",
        "@resources//mono.posix.netstandard",
        "@resources//microsoft.codeanalysis.csharp",
        "@resources//microsoft.codeanalysis.visualbasic",
        "@resources//microsoft.codeanalysis.common",
        "@resources//microsoft.codeanalysis.analyzers",
        "@resources//system.codedom",
        "@resources//system.configuration.configurationmanager",
        "@resources//mono.cecil",
        "@resources//ironpython",
    ],
    resources = [
        "@RenodeInfrastructure//:Antmicro.Renode.translate-arm-m-le.so",
    ],
    defines = ["NET"],
    out = "Renode",
    winexe = True,
)
publish_binary(
    name = "publish_renode",
    binary = ":Renode",
    runtime_packs = select({
        "@rules_dotnet//dotnet:rid_linux-x64": ["@rules_dotnet_dev_nuget_packages//microsoft.netcore.app.runtime.linux-x64"],
        "@rules_dotnet//dotnet:rid_osx-x64": ["@rules_dotnet_dev_nuget_packages//microsoft.netcore.app.runtime.osx-x64"],
        "@rules_dotnet//dotnet:rid_win-x64": ["@rules_dotnet_dev_nuget_packages//microsoft.netcore.app.runtime.win-x64"],
    }),
    self_contained = True,
    target_framework = "net6.0",
)
