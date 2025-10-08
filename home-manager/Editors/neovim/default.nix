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
    neovim.defaultEditor = true;
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
      };

      extraBinPath = import ./binaries.nix { inherit pkgs; };
      extraLuaPackages =
        ps: with ps; [
          jsregexp
          magick
        ];

      plugins = {
        start = import ./startPlugins.nix { inherit pkgs; };

        opt = import ./optPlugins.nix { inherit pkgs; };

        dev.myconfig = {
          pure = ./nvim;
          impure = "/' .. vim.uv.cwd() .. '/nvim";
        };
      };
    };
  };
}
