{ pkgs }:
let 
  pkgsPlugins = with pkgs.vimPlugins; [
    aerial-nvim # for amazing code outline

    trouble-nvim

    # Better lsp
    lspsaga-nvim

    # For completion
    blink-cmp
    blink-emoji-nvim
    blink-ripgrep-nvim
    blink-cmp-spell

    # For markdown files
    markdown-preview-nvim
    render-markdown-nvim

    # For file explorer
    neo-tree-nvim
    nvim-lsp-file-operations # load at event="LspAttach"
    nvim-window-picker
    image-nvim

    # for a better ui
    fidget-nvim

    gitlinker-nvim
    hunk-nvim
    lazygit-nvim

    colorful-menu-nvim
  ];
in pkgsPlugins
