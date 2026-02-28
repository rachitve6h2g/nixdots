{
  inputs,
  self,
  ...
}:
let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
{
  flake = {
    homeConfigurations."krish" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        self.homeModules.krish
      ];
    };

    homeModules = {
      krish =
        { pkgs, lib, ... }:
        {
          imports = [
            self.homeModules.desktop
          ];
          nix = {
            settings = {
              cores = 8;
              max-jobs = 1;
            };
            package = pkgs.lix;
          };

          home = {
            username = "krish";
            homeDirectory = "/home/krish";
            stateVersion = "25.11";
          };

          programs.home-manager.enable = true;
        };
    };
  };
}
