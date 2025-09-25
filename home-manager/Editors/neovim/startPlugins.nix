{ pkgs, ... }:
let
  startPlugins = with pkgs.vimPlugins; [ 
    gruvbox-nvim # eyes stay healthy

    lz-n # for lazyloading

    nvim-treesitter # tree-sitter setup
    nvim-lspconfig # for lsp
  ];

  treeSitterGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p;
  [
    comment # for comments
    lua # for lua nvim
    luadoc # for lua again
    nix # for nix
  ]);
in
startPlugins ++ [ treeSitterGrammars ]
