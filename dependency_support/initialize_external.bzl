load("@rules_python//python:pip.bzl", "pip_parse")
load("@python311//:defs.bzl", python_interpreter_target = "interpreter")
load("//dependency_support/nuget_packages:nuget.bzl", load_nuget_packages="nuget_packages")
load("@rules_dotnet//dotnet:rules_dotnet_nuget_packages.bzl", "rules_dotnet_nuget_packages")
load("@rules_dotnet//dotnet:rules_dotnet_dev_nuget_packages.bzl", "rules_dotnet_dev_nuget_packages")
load("//dependency_support/renode-resources:resources.bzl", "renode_resources")

def initialize_external_repositories():
    pip_parse(
        name = "renode_pip_deps",
        requirements_lock = "@com_antmicro_renode//dependency_support:pip_requirements_lock.txt",
        python_interpreter = python_interpreter_target,
    )

    rules_dotnet_nuget_packages()
    rules_dotnet_dev_nuget_packages()

    load_nuget_packages()

    renode_resources()
