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

      # initLua = # lua
      #   ''
      #     ${builtins.readFile ./init.lua}
      #   '';

      neovim = pkgs.neovim-unwrapped;

      providers = {
        nodeJs.enable = true;
        perl = {
          enable = true;
          extraPackages =
            p: with p; [
              NeovimExt # Defaults must
              Appcpanminus # be present

              DirManifest
            ];
        };
      };

      extraBinPath = import ./binaries.nix { inherit pkgs; };
      extraLuaPackages =
        ps: with ps; [
          jsregexp
          lua-utils-nvim
          magick
          pathlib-nvim
        ];

      plugins = {
        start = import ./startPlugins.nix { inherit pkgs; };
        startAttrs = {
          "blink.cmp" = null;
        };
        opt = import ./optPlugins.nix { inherit pkgs; };

        dev.myconfig = {
          pure = ./nvim;
          impure = "/' .. vim.uv.cwd() .. '/nvim";
        };
      };
    };
  };
}
