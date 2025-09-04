{ pkgs, ... }: let
  rose-pine-btop = (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/rose-pine/btop/refs/heads/main/rose-pine-moon.theme";
    hash = "sha256-iJNhWAQ6xzl6EsI0wWxtN14/KqZ7YWZFJaqFOZjLO8g=";
  });
in {
  programs.btop = {
    enable = true;
    themes = {
      rose-pine = ''${rose-pine-btop}'';
    };
    settings = {
      # color_theme = "rose-pine";
      theme_background = false;
      vim_keys = true;
      rounded_corners = true;
    };
  };

  # IN locale doesn't have utf-8 encoding.
  # programs.zsh.shellAliases.btop = "btop --force-utf";
}
