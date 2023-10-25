workspace(name = "com_antmicro_renode")

load("//renode_sources:load_renode.bzl", "load_renode_sources")
load_renode_sources()

load("//dependency_support:load_external.bzl", "load_external_repositories")
load_external_repositories()

load("@rules_python//python:repositories.bzl", "py_repositories", "python_register_toolchains")
py_repositories()
python_register_toolchains(
    name = "python311",
    python_version = "3.11",
)

load("@rules_dotnet//dotnet:repositories.bzl", "dotnet_register_toolchains", "rules_dotnet_dependencies")
rules_dotnet_dependencies()
# Here you can specify the version of the .NET SDK to use.
dotnet_register_toolchains("dotnet", "7.0.101")

load("//dependency_support:initialize_external.bzl", "initialize_external_repositories")
initialize_external_repositories()

load("@renode_pip_deps//:requirements.bzl", renode_pip_install_deps = "install_deps")
renode_pip_install_deps()


