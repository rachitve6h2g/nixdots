{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mediainfo # for mediainfo.yazi
    rich-cli # for readme viewing
    trash-cli # for restore.yazi
    p7zip-rar # for extraction
  ];

  programs = {
    yazi = {
      enable = true;
      shellWrapperName = "y";

      package = pkgs.yazi.override { _7zz = pkgs.p7zip-rar; };

      plugins = (import ./plugins.nix { inherit pkgs; });

      settings = (import ./yazitoml.nix);
      keymap = (import ./keymap.nix);

      initLua = builtins.readFile ./init.lua;
    };
  };
}
