{ pkgs, ... }:
let
  pkgsPlugins = with pkgs.vimPlugins; [
    telescope-nvim
    trouble-nvim
    render-markdown-nvim

    # Better lsp
    lspsaga-nvim

    # For completion
    blink-cmp

    # For file explorer
    mini-files
  ];
in
pkgsPlugins
