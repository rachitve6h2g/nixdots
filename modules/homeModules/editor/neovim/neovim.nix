{ inputs, ... }:
{
  flake.homeModules.neovim =
    {
      pkgs,
      config,
      lib,
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

        gitui = {
          enable = true;
          keyConfig =
            let
              vim_keybindings = /* ron */ ''
                // Note:
                // If the default key layout is lower case,
                // and you want to use `Shift + q` to trigger the exit event,
                // the setting should like this `exit: Some(( code: Char('Q'), modifiers: "SHIFT")),`
                // The Char should be upper case, and the modifier should be set to "SHIFT".
                //
                // Note:
                // find `KeysList` type in src/keys/key_list.rs for all possible keys.
                // every key not overwritten via the config file will use the default specified there
                (
                    open_help: Some(( code: F(1), modifiers: "")),

                    move_left: Some(( code: Char('h'), modifiers: "")),
                    move_right: Some(( code: Char('l'), modifiers: "")),
                    move_up: Some(( code: Char('k'), modifiers: "")),
                    move_down: Some(( code: Char('j'), modifiers: "")),

                    popup_up: Some(( code: Char('p'), modifiers: "CONTROL")),
                    popup_down: Some(( code: Char('n'), modifiers: "CONTROL")),
                    page_up: Some(( code: Char('b'), modifiers: "CONTROL")),
                    page_down: Some(( code: Char('f'), modifiers: "CONTROL")),
                    home: Some(( code: Char('g'), modifiers: "")),
                    end: Some(( code: Char('G'), modifiers: "SHIFT")),
                    shift_up: Some(( code: Char('K'), modifiers: "SHIFT")),
                    shift_down: Some(( code: Char('J'), modifiers: "SHIFT")),

                    edit_file: Some(( code: Char('I'), modifiers: "SHIFT")),

                    status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),

                    diff_reset_lines: Some(( code: Char('u'), modifiers: "")),
                    diff_stage_lines: Some(( code: Char('s'), modifiers: "")),

                    stashing_save: Some(( code: Char('w'), modifiers: "")),
                    stashing_toggle_index: Some(( code: Char('m'), modifiers: "")),

                    stash_open: Some(( code: Char('l'), modifiers: "")),

                    abort_merge: Some(( code: Char('M'), modifiers: "SHIFT")),
                )
              '';
            in
            lib.mkMerge [ vim_keybindings ];
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
