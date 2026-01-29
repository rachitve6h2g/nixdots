{ inputs, ... }:
{
  flake.nixosModules.nix =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [ inputs.nix-index-database.nixosModules.nix-index ];
      # Add $HOME/.local/bin to the $PATH variable.
      environment = {
        localBinInPath = true;
        variables = {
          QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt6.qtbase.outPath}/lib/qt-6/plugins";
        };

        pathsToLink = [ "/share/bash-completion" ];
      };

      nixpkgs = {
        config.allowUnfree = true;
      };

      programs = {
        nh = {
          enable = true;
          clean = {
            enable = true;
            dates = "daily";
            extraArgs = "--keep 5 --keep-since 3d";
          };
          flake = "/etc/nixos";
        };
        nix-index-database.comma.enable = true;
      };

      nix =
        let
          flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
        in
        {
          package = pkgs.lix;
          settings = {
            experimental-features = "nix-command flakes";
            nix-path = config.nix.nixPath;

            auto-optimise-store = true;
          };
          optimise = {
            automatic = true;
            dates = [ "03:45" ];
          };
          channel.enable = false;

          registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
          nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
        };
    };
}
