{ pkgs, ... }:
let
  pkgsPlugins = with pkgs.vimPlugins; [
    # For colorscheme
    # gruvbox-material
    # kanagawa-nvim
    catppuccin-nvim

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
    luasnip
    conform-nvim
    lspkind-nvim

    # Notifications/UI
    mini-ai # For textobjects
    mini-pairs # Fro autopairing
    mini-comment # For comment declaration
    mini-surround # For surrounds
    mini-starter # for a nice banner

    neorg
    neorg-telescope

    neoscroll-nvim

    nvim-notify
    nvim-navic

    indent-blankline-nvim
    rainbow-delimiters-nvim

    # very handy plugin
    telescope-nvim
    telescope-fzf-native-nvim

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

    toggleterm-nvim # Better loaded at startup

    nvim-colorizer-lua # for color color
  ];

  treeSitterGrammars =
    let
      treesitter-norg = pkgs.tree-sitter-grammars.tree-sitter-norg;
      treesitter-norg-meta = pkgs.tree-sitter-grammars.tree-sitter-norg-meta;
    in
    (pkgs.vimPlugins.nvim-treesitter.withPlugins (
      p:
      with p;
      [
        bash
        comment
        fish
        ini # for ini filetypes
        kdl
        luadoc

        # for markdown
        markdown
        markdown-inline

        query

        html
        latex

        qmljs
        gitignore
        git_rebase
        css
        json
        toml
        yaml
        muttrc
        nix
        c
        cpp
        lua
        regex
        ron
        zathurarc
      ]
      ++ [
        treesitter-norg
        treesitter-norg-meta
      ]
    ));
in
pkgsPlugins ++ [ treeSitterGrammars ]
