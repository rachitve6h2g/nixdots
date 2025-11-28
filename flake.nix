{
  # Template credit goes to Misterio77/nix-starter-configs
  description = "Krish's flake";

  inputs = {
    disko.url = "github:nix-community/disko";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # mnw.url = "github:Gerg-L/mnw";

    # Use this while installing a new system.
    knvim.url = "github:rachitve6h2g/knvim";
    # knvim.url = "path:/home/krish/Downloads/knvim";

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake
      {
        inherit inputs;
      }
      {
        systems = [ "x86_64-linux" ];
        imports = [
          flake-parts.flakeModules.flakeModules
          ./nixos.nix
          ./pkgs

          inputs.disko.flakeModules.default
        ];
      };
}
