{ pkgs, ... }:
let
  pkgsPlugins = with pkgs.vimPlugins; [
    # For colorscheme
    gruvbox-material-nvim

    # Plugin manager helper
    lz-n

    # Icons and utils
    # nvim-web-devicons
    nvim-window-picker

    # Completion and LSP
    blink-cmp
    lazydev-nvim
    nvim-lspconfig
    luasnip
    conform-nvim

    # Notifications/UI
    mini-ai # For textobjects
    mini-diff # for diff info in statusline
    mini-notify
    mini-statusline # for statusline
    mini-git # for git info in statusline
    mini-icons # for icons
    mini-pairs # Fro autopairing
    mini-comment # For comment declaration

    mini-snippets # For completion
    mini-completion # For completion
    mini-clue # lightweight which-key replacement
    mini-files # File explorer

    # Aesthetics mini
    mini-animate # for aesthetics
    mini-cursorword # highlight the word which cursor points
    mini-hipatterns # For highlighting colors and TODO and stuff
    mini-indentscope # The name says it
    mini-starter # For a banner
    mini-tabline # For a cool tabline.

    markdown-preview-nvim

    # For nix
    vim-nix
    vim-nixhash
  ];

  treeSitterGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (
    p: with p; [
      bash
      comment
      fish
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
