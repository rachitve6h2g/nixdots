{ self, ... }:
let
  inherit (self) theme;
in
{
  flake.wrappers.gitui =
    {
      wlib,
      config,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
        # wlib.wrapperModules.git
        wlib.modules.default
      ];
      options =
        let
          inherit (lib) mkOption;
          commitMsgHook = pkgs.writeShellScript "commit-msg" ''
            ${lib.getExe pkgs.gitlint} --msg-filename "$1"
          '';
          gitHooks = pkgs.runCommand "git-hooks" { } ''
            mkdir -p $out
            ln -s ${commitMsgHook} $out/commit-msg
          '';
          gitIgnores = [
            "*.bak"
            "*~"
            "*.tmp"
            ".direnv"
          ];

          globalIgnoreFiles = pkgs.writeText "global-gitignore" (lib.concatStringsSep "\n" gitIgnores + "\n");
        in
        {
          keyConfig = mkOption {
            type = wlib.types.file pkgs;
            default.content = /* ron */ ''
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
          };
          theme = mkOption {
            type = wlib.types.file pkgs;
            default.content = # ron
              with theme; ''
                (
                  selected_tab: Some("Reset"),
                  command_fg: Some("${base05}"),
                  selection_bg: Some("${base04}"),
                  selection_fg: Some("${base05}"),
                  cmdbar_bg: Some("${base01}"),
                  cmdbar_extra_lines_bg: Some("${base01}"),
                  disabled_fg: Some("${base04}"),
                  diff_line_add: Some("${base0B}"),
                  diff_line_delete: Some("${base08}"),
                  diff_file_added: Some("${base0A}"),
                  diff_file_removed: Some("${base08}"),
                  diff_file_moved: Some("${base0E}"),
                  diff_file_modified: Some("${base09}"),
                  commit_hash: Some("${base07}"),
                  commit_time: Some("${base05}"),
                  commit_author: Some("${base0D}"),
                  danger_fg: Some("${base08}"),
                  push_gauge_bg: Some("${base0D}"),
                  push_gauge_fg: Some("${base00}"),
                  tag_fg: Some("${base06}"),
                  branch_fg: Some("${base0C}")
                )
              '';
          };
          gitconfig = mkOption {
            type = wlib.types.subWrapperModule [
              self.wrapperModules.git
              { inherit pkgs; }
            ];
            default = { };
          };
        };

      config = {
        env.GIT_CONFIG_GLOBAL = config.gitconfig.configFile.path;
        package = pkgs.gitui;
        extraPackages = [ config.gitconfig.wrapper ];
        flags = {
          "--key-bindings" = config.keyConfig.path;
          "--theme" = config.theme.path;
        };
      };
    };
}
