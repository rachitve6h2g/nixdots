{ pkgs, config, ... }:
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
}
