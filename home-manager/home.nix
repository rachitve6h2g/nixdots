{ osConfig, ... }:
{
  home = rec {
    username = "krish";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = true;
  };
  programs = {
    home-manager.enable = true;

    nix-index = {
      enable = osConfig.programs.nix-index.enable;
      enableBashIntegration = osConfig.programs.nix-index.enableBashIntegration;
    };
  };

  imports = [
    ./Browsers
    ./Editors
    ./Git
    ./Hyprland
    ./Media
    ./Programs
    ./Shell

    ./keymap.nix
    ./nh.nix
    ./stylix.nix
    ./xdgsettings.nix
  ];
}
