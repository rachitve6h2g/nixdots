{ inputs, config, ... }:
let
  globalValues = config.globalValues;
in
{
  flake = {
    nixosConfigurations = {
      ${globalValues.hostname} = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit globalValues;
        };
        
        modules = [
          ./${globalValues.hostname}
          ./overlays

          ./Common
        ];
      };
    };

    diskoConfigurations.${globalValues.hostname} = import ./${globalValues.hostname}/disko-config.nix;
  };
}
