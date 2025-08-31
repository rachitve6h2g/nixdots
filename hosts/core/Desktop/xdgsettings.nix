{ pkgs, ... }:
{
  xdg = {
    terminal-exec = {
      enable = true;
      package = pkgs.xdg-terminal-exec;
      settings = {
        default = [
          "kitty.desktop"
        ];

        niri = [ "kitty.desktop" ];
      };
    };
    icons = {
      enable = true;
    };
    menus.enable = true;
    sounds.enable = true;
  };
}
