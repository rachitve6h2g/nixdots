{ pkgs, ... }:
let
  optPlugins = with pkgs.vimPlugins; [
    neo-tree-nvim # for file picker
    nui-nvim # dependency of neo-tree
    plenary-nvim # dependency of neo-tree again
    nvim-web-devicons # dependency of neo-tree
    nvim-lsp-file-operations # for lsp enhanced renames
    snacks-nvim # for image preview
    nvim-window-picker

    nvim-autopairs # for auto-pairs
  ];
in
optPlugins
