{ config, pkgs, ...}: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
      };
      "org/gnome/desktop/input-sources" = {
        xkb-options = [ "ctrl:nocaps" ];
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = config.home.pointerCursor.name;
        cursor-size = config.home.pointerCursor.size;
      };
    };
  };

  home.packages = [ pkgs.gnome-tweaks ];
}
