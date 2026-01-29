{
  # Template credit goes to Misterio77/nix-starter-configs
  description = "Krish's flake";

  inputs = {
    disko.url = "github:nix-community/disko";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree"; # Used with flake parts.

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mnw.url = "github:Gerg-L/mnw";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-qml-support = {
      url = "github:outfoxxed/nix-qml-support";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: Idea is to wrap as many packages as possible
    # using the nix module system.
    # Currently wrapped is btop without the wrappers library.
    wrappers.url = "github:lassulus/wrappers";

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
          ./globals.nix
          flake-parts.flakeModules.flakeModules
          ./hosts
          # ./pkgs
          # ./users
          inputs.disko.flakeModules.default
          inputs.home-manager.flakeModules.home-manager
          (inputs.import-tree ./modules)
        ];
      };
}
