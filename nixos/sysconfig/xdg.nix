{ config, pkgs, ... }:
{
  # xdg desktop portal
  environment = {
    systemPackages = with pkgs; [ sound-theme-freedesktop ];
    pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };
  xdg = {
    portal = config.home-manager.users.krish.xdg.portal // {
      wlr.enable = true;
    };
    # Enable xdg-sounds
    sounds.enable = true;
  };
}
