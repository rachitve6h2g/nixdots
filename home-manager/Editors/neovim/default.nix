{ inputs, ... }:
{
  imports = [ inputs.nvf.homeManagerModules.default ];

  stylix.targets = {
    neovim.enable = false;
    neovide.enable = false;
    nixvim.enable = false;
    nvf = {
      enable = true;
      transparentBackground = true;
    };
  };

  programs = {
    nvf = {
      enable = true;
      settings = {
        imports = [
          ./plugins
        ];
        vim = {
          clipboard = {
            enable = true;
            providers = {
              wl-copy = {
                enable = true;
              };
            };
            registers = "unnamedplus";
          };

          globals = rec {
            mapleader = " ";
            maplocalleader = mapleader;
          };

          viAlias = true;
          vimAlias = true;

          # Theme will be managed by stylix
          # theme = {
          #   enable = true;
          #   name = lib.mkForce "gruvbox";
          #   style = "dark";
          #   transparent = lib.mkForce true;
          # };

          undoFile = {
            enable = true;
          };
          syntaxHighlighting = true;
          options = {
            relativenumber = true;
            mouse = "a";
            signcolumn = "yes";
            updatetime = 250;
            splitright = true;
            splitbelow = true;
            # cursorline = true;
            # cursorlineopt = "both";
            shiftwidth = 0;
            tabstop = 2;
            termguicolors = true;
            autoindent = true;
            wrap = false;
            confirm = true;
          };
        };
      };
    };
  };
}
