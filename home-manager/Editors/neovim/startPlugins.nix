{ pkgs, ... }:
let
  pkgsPlugins = with pkgs.vimPlugins; [
    # For colorscheme
    gruvbox-nvim

    # Plugin manager helper
    lz-n

    # Icons and utils
    nvim-web-devicons
    nvim-window-picker

    lualine-nvim

    # Completion and LSP
    lazydev-nvim
    nvim-lspconfig
    luasnip
    conform-nvim

    # Notifications/UI
    mini-ai # For textobjects
    mini-diff # for diff info in statusline
    mini-notify
    mini-pairs # Fro autopairing
    mini-comment # For comment declaration

    mini-clue # lightweight which-key replacement
    mini-surround # For surrounds

    # Aesthetics mini
    mini-animate # for aesthetics
    mini-cursorword # highlight the word which cursor points
    mini-hipatterns # For highlighting colors and TODO and stuff
    mini-indentscope # The name says it
    mini-starter # For a banner
    mini-tabline # For a cool tabline.

    markdown-preview-nvim

    # For nix
    # vim-nix
    vim-nixhash

    # clang for c/c++
    clangd_extensions-nvim
  ];

  treeSitterGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (
    p: with p; [
      bash
      comment
      fish
      kdl
      luadoc
      qmljs
      gitignore
      git_rebase
      css
      html
      json
      toml
      yaml
      nix
      c
      lua
      regex
      zathurarc
    ]
  );
in
pkgsPlugins ++ [ treeSitterGrammars ]
