{pkgs, lib, inputs, config, ... }: {

  imports = [
    ./DesktopEnvironment
    ./Programs
    ./SystemConfiguration
    
    ./stylix.nix
    ./users.nix
  ];
  documentation.man.generateCaches = false;

  # Add $HOME/.local/bin to the $PATH variable.
  environment = {
    localBinInPath = true;
    variables = {
      QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt6.qtbase.outPath}/lib/qt-6/plugins";
    };
    
    pathsToLink = [ "/share/bash-completion" ];
  };

  system.stateVersion = "26.05";

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
      {
        settings = {
          experimental-features = "nix-command flakes";
          nix-path = config.nix.nixPath;
        };
        channel.enable = false;

        registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      };
}
