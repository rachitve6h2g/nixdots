{ pkgs, ... }:
let
  pkgsPlugins = with pkgs.vimPlugins; [
    # For colorscheme
    # gruvbox-material
    kanagawa-nvim

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
      # treesitter-norg = pkgs.tree-sitter.buildGrammar {
      #   language = "norg";
      #   version = "v0.2.6";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "nvim-neorg";
      #     repo = "tree-sitter-norg";
      #     rev = "1aab69c95bd9d5e7c0e172ecbe5d29bcf5834612";
      #     hash = "sha256-DxRu3LG/aF2BG4SYOKTj9/WHIryAYuY4THvwKPSmRIs=";
      #   };
      #   meta.homepage = "https://github.com/nvim-neorg/tree-sitter-norg";
      # };
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
        nix
        c
        cpp
        lua
        regex
        zathurarc
      ]
      ++ [
        treesitter-norg
        treesitter-norg-meta
      ]
    ));
in
pkgsPlugins ++ [ treeSitterGrammars ]
