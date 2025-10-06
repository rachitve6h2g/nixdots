{ pkgs, ... }:
let
  pkgsPlugins = with pkgs.vimPlugins; [
    # For colorscheme
    gruvbox-material

    # for git integration
    git-conflict-nvim
    gitsigns-nvim

    # Plugin manager helper
    lz-n
    lzn-auto-require

    bufferline-nvim

    # Icons and utils
    nvim-web-devicons

    nvim-lightbulb

    noice-nvim

    lualine-nvim

    # Completion and LSP
    lazydev-nvim
    nvim-lspconfig
    luasnip
    conform-nvim
    lspkind-nvim

    # Notifications/UI
    mini-ai # For textobjects
    mini-pairs # Fro autopairing
    mini-comment # For comment declaration

    mini-clue # lightweight which-key replacement
    mini-surround # For surrounds

    # Aesthetics mini
    mini-animate # for aesthetics
    mini-cursorword # highlight the word which cursor points
    mini-hipatterns # For highlighting colors and TODO and stuff
    mini-starter # For a banner
    mini-tabline # For a cool tabline.

    markdown-preview-nvim

    nvim-notify
    nvim-navic

    indent-blankline-nvim
    rainbow-delimiters-nvim

    # For nix
    vim-nix
    vim-nixhash

    # clang for c/c++
    clangd_extensions-nvim

    # Library for a lot of plugins, must eager load
    nui-nvim
    plenary-nvim

    nvim-treesitter-context

    which-key-nvim
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
