{ inputs, ... }:
{
  imports = [
    # currently unused
    inputs.home-manager.flakeModules.home-manager
    inputs.flake-parts.flakeModules.modules
  ];

  options = {
    flake = inputs.flake-parts.lib.mkSubmoduleOptions {
      wrapperModules = inputs.nixpkgs.lib.mkOption {
        default = { };
      };
    };
  };

  config = {
    systems = [
      "x86_64-linux"
    ];
  };
}
