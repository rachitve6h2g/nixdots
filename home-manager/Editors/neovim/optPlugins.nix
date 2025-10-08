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
    blink-emoji-nvim
    blink-ripgrep-nvim
    blink-cmp-spell

    # For file explorer
    neo-tree-nvim
    nvim-lsp-file-operations # load at event="LspAttach"
    nvim-window-picker
    image-nvim

    fidget-nvim

    gitlinker-nvim
    hunk-nvim
    lazygit-nvim

    colorful-menu-nvim
  ];
in
pkgsPlugins
