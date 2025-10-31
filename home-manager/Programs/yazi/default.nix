{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mediainfo # for mediainfo.yazi
    rich-cli # for readme viewing
    trash-cli # for recycle-bin.yazi
    _7zz-rar # for extraction
  ];

  programs = {
    yazi = {
      enable = true;
      shellWrapperName = "y";
      enableBashIntegration = true;

      package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; };

      plugins = (import ./plugins.nix { inherit pkgs; });

      settings = (import ./yazitoml.nix);
      keymap = (import ./keymap.nix);

      initLua = builtins.readFile ./init.lua;
    };
  };
}
