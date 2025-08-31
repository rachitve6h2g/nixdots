{
  imports = [
    ./keymap.nix
    ./stylix.nix
    ./terminal.nix
    ./xdgsettings.nix

    ./Browsers
    ./Desktop
    ./Editors
    ./Git
    ./Media
    ./Programs
    ./Shell
  ];

  programs.nh = rec {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 3d";
    };
    flake = "/home/krish/.dotfiles";
    homeFlake = "${flake}";
    osFlake = "${flake}";
  };

  home = rec {
    username = "krish";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = true;
  };
  programs.home-manager = {
    enable = true;
  };
  services.home-manager = {
    autoUpgrade = {
      enable = true;
      frequency = "weekly";
    };
  };

  nixpkgs.config.allowUnfree = true;
}
