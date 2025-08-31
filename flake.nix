{
  description = "My experimental flake";

  inputs = {
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    git-hooks-nix.url = "github:cachix/git-hooks.nix";

    home-manager = {
      url = "github:nix-community/home-manager"; # The nixpkgs version and home-manager version should be same
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ironbar = {
      url = "github:JakeStanger/ironbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mnw.url = "github:Gerg-L/mnw";

    niri-flake.url = "github:sodiboo/niri-flake";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix"; # use "github:nix-community/stylix" for stable.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };
  };

  outputs =
    {
      flake-parts,
      # nixpkgs,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];
      imports = [
        ./hosts
        ./modules/treefmt/flake-module.nix
        inputs.git-hooks-nix.flakeModule
        inputs.home-manager.flakeModules.home-manager
      ];

      flake = {
        homeConfigurations.krish = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            ./home
            inputs.stylix.homeModules.stylix
          ];
        };
      };

      perSystem =
        {
          pkgs,
          # system,
          ...
        }:
        {
          pre-commit.settings.hooks.nixfmt-rfc-style.enable = true;
          formatter = pkgs.nixfmt-rfc-style;
        };
    };
}
