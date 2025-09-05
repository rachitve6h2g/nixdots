{ pkgs, ... }:
let
  pkgsPlugins = with pkgs.vimPlugins; [
    telescope-nvim
    trouble-nvim
    render-markdown-nvim
  ];
in
pkgsPlugins
