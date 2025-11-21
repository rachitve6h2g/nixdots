{ pkgs, ... }:
{
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman

        thunar-vcs-plugin
        thunar-media-tags-plugin
      ];
    };
  };

  home-manager.users.krish.xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
  '';

  services = {
    gvfs = {
      enable = true;
      package = pkgs.gvfs.override { gnomeSupport = false; };
    };
    tumbler.enable = true;
  };
}
