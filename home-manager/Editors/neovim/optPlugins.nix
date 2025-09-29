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
    neo-tree-nvim
    nui-nvim
    plenary-nvim
    nvim-lsp-file-operations # load at event="LspAttach"
    nvim-window-picker
    image-nvim
  ];
in
pkgsPlugins
