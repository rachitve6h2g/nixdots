{ inputs, ... }:
{
  flake.homeModules.neovim =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = [ inputs.mnw.homeManagerModules.mnw ];
      home.sessionVariables.EDITOR = "nvim";
      programs = {
        bash = {
          sessionVariables.EDITOR = config.home.sessionVariables.EDITOR;
          bashrcExtra = ''
            set -o vi
          '';
        };
        mnw = {
          enable = true;

          appName = "nvim";
          desktopEntry = false;

          aliases = [
            "vim"
            "vi"
          ];

          # luaFiles = [
          #   ./init.lua
          # ];

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

          extraLuaPackages =
            ps: with ps; [
              jsregexp
              lua-utils-nvim
              magick
              pathlib-nvim
            ];

          neovim = pkgs.neovim-unwrapped;
          plugins = {
            startAttrs = {
              "blink.cmp" = null; # Already loaded by opt plugins
            };
            start = import ./packages/_startPlugins.nix { inherit pkgs; };
            # start = import ./packages/treesitter.nix { inherit pkgs; };
            # optAttrs = import ./packages/optPlugins.nix { inherit pkgs; };
            opt = import ./packages/_optPlugins.nix { inherit pkgs; };

            dev.myconfig = {
              pure = ./nvim;
              impure = "/home/krish/Documents/projects/neovim/nvim";
            };
          };

          extraBinPath = import ./packages/_binaries.nix { inherit pkgs; };
        };
      };
    };
}
