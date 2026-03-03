{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.wrappers.flakeModules.wrappers
  ];

  config = {
    systems = [
      "x86_64-linux"
    ];
    perSystem.wrappers.control_type = "exclude"; # Build every wrapper into packages.*.* by default
  };
}
