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
