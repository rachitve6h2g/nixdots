{ inputs, pkgs, ... }:
{
  imports = [ inputs.mnw.homeManagerModules.mnw ];

  stylix.targets = {
    neovim.enable = false;
    neovide.enable = false;
    nixvim.enable = false;
    nvf.enable = false;
  };

  programs = {
    mnw = {
      enable = true;

      aliases = [
        "vim"
        "vi"
      ];

      desktopEntry = false;

      initLua = # lua
        ''
          require("myconfig")
          require('lz.n').load('lazy')
          vim.lsp.enable({ "nixd", "lua_ls", "qmlls", "marksman" })
        '';

      neovim = pkgs.neovim-unwrapped;

      providers = {
        nodeJs.enable = true;
      };

      extraBinPath = with pkgs; [
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
      ];

      extraLuaPackages = ps: with ps; [ jsregexp ];

      plugins = {
        start = with pkgs.vimPlugins; [
          bufferline-nvim

          gruvbox-material-nvim
          lz-n

          neo-tree-nvim
          nui-nvim
          nvim-lsp-file-operations

          nvim-web-devicons
          snacks-nvim
          nvim-window-picker

          aerial-nvim

          blink-cmp
          colorful-menu-nvim
          lazydev-nvim

          nvim-surround
          nvim-lspconfig
          lualine-nvim
          lualine-lsp-progress
          nvim-autopairs
          luasnip
          rainbow-delimiters-nvim
          indent-blankline-nvim

          nvim-highlight-colors

          noice-nvim
          mini-notify

          which-key-nvim

          plenary-nvim
          helpview-nvim
          markdown-preview-nvim
          conform-nvim
          (nvim-treesitter.withPlugins (
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
          ))

          stay-centered-nvim

          vim-nix

          vim-nixhash
        ];
        opt = with pkgs.vimPlugins; [
          telescope-nvim
          trouble-nvim
          render-markdown-nvim
        ];

        dev.myconfig = {
          pure = ./nvim;
          impure = "/' .. vim.uv.cwd() .. '/nvim";
        };
      };
    };
  };
}
