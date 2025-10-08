{
  pkgs,
  config,
  # lib,
  ...
}:
{
  stylix = {
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    iconTheme = {
      enable = true;
      package = pkgs.gruvbox-plus-icons.override { folder-color = "purple"; };
      light = "Gruvbox-Plus-Dark";
      # package = pkgs.catppuccin-papirus-folders.override { accent = "mauve"; };
      # light = "Papirus";
      dark = config.stylix.iconTheme.light;
    };
  };

  home.pointerCursor = {
    dotIcons.enable = false;
  };

  gtk = rec {
    enable = true;

    gtk2 = {
      extraConfig = ''
        gtk-toolbar-style = GTK_TOOLBAR_BOTH_HORIZ
        gtk-toolbar-icon = GTK_ICON_SIZE_SMALL_TOOLBAR
        gtk-button-images = 0
        gtk-menu-images = 0
        gtk-enable-event-sounds = 0
        gtk-enable-input-feedback-sounds = 0
        gtk-xft-antialias = 1
        gtk-xft-hinting = 1
        gtk-xft-hintstyle = "hintslight"
        gtk-xft-rgba = "rgb"
      '';
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "menu:close";
      gtk-toolbar-style = "GTK_TOOLBAR_BOTH_HORIZ";
      gtk-toolbar-icon-size = "GTK_ICON_SIZE_SMALL_TOOLBAR";
      gtk-button-images = 0;
      gtk-menu-images = 0;
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
    };
    gtk4.extraConfig = gtk3.extraConfig;
  };
}
