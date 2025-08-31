{ pkgs, ... }:
{
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman

        # This is in unstable branch for now (25.05)
        #thunar-vcs-plugin
        thunar-media-tags-plugin
      ];
    };
  };

  services = {
    gvfs = {
      enable = true;
      package = pkgs.gvfs.override { gnomeSupport = false; };
    };
    tumbler.enable = true;
  };
}
