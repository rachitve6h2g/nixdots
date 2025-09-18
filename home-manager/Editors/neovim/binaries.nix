{ pkgs, ... }:
let
  packages = with pkgs; [
    wl-clipboard
    ripgrep
    ruff
    sqls
    fzf
    fd
    marksman
    gcc-unwrapped
    git
    bash-language-server
    nixd
    nixfmt
    stylua
    lua-language-server
    kdePackages.qtdeclarative # for qmlls
    tree-sitter # For tree-sitter executable
  ];
in
packages
