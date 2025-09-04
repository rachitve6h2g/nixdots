{
  pkgs,
  config,
  lib,
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

  home.pointerCursor =
    let
      stylix_cursor = config.stylix.cursor;
    in
    {
      dotIcons.enable = false;

      hyprcursor = {
        enable = true;
        size = stylix_cursor.size;
      };
    };

  gtk = {
    enable = true;

    theme = {
      package = lib.mkForce (
        pkgs.gruvbox-gtk-theme.override {
          colorVariants = [ "dark" ];
          sizeVariants = [ "standard" ];
          themeVariants = [ "yellow" ];
          tweakVariants = [
            "black"
            "macos"
          ];
          iconVariants = [ "Dark" ];
        }
      );

      name = lib.mkForce "Gruvbox-Yellow-Dark";
    };
  };
}
