{ inputs, ... }:
{
  flake = {
    nixosConfigurations = {
      nixpavilion = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos

          # ./pkgs
          ./overlays

          inputs.home-manager.nixosModules.home-manager

          {
            home-manager = {
              extraSpecialArgs = { inherit inputs; };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.krish = ./home-manager/home.nix;
            };
          }
        ];
      };
    };

    diskoConfigurations.nixpavilion = import ./nixos/disko-config.nix;
  };
}
