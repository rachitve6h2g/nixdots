{ pkgs, ... }:
let
  rose-pine-btop = (
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rose-pine/btop/refs/heads/main/rose-pine-moon.theme";
      hash = "sha256-iJNhWAQ6xzl6EsI0wWxtN14/KqZ7YWZFJaqFOZjLO8g=";
    }
  );
in
{
  programs = {
    htop.enable = true;
    btop = {
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
  };
}
