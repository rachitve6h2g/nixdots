{ pkgs, ... }:
let
  packages = with pkgs; [
    curl
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
    libclang

    # C compiler for treesitter
    gcc

    imagemagick
    taplo # LSP for TOML

    python313Packages.pylatexenc
  ];
in
packages
