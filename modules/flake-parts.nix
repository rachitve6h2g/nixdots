{ inputs, ... }:
{
  imports = [
    # currently unused
    inputs.home-manager.flakeModules.home-manager
    inputs.flake-parts.flakeModules.modules
    inputs.wrappers.flakeModules.wrappers
  ];

  config = {
    systems = [
      "x86_64-linux"
    ];
  };
}
