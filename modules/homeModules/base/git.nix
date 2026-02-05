{
  flake.homeModules.shell =
    {
      pkgs,
      lib,
      ...
    }:
    {

      programs = {
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
        git = {
          enable = true;
          package = pkgs.git.override { withLibsecret = true; };

          # Set files that should be ignored globally
          ignores = [
            # Ignore emacs backup files
            "*~"
            "\#*\#"
            ".\#*"

            # Ignore vim backup files
            "*.swp"
          ];

          settings = {
            remote = {
              pushDefault = "origin";
            };

            user = {
              name = "Rachit Kumar Verma";
              email = "rachitve6h2g@users.noreply.github.com";
            };
            alias = {
              co = "checkout";
              s = "status";
              ss = "status --short --branch";
              ci = "commit";
            };
          };
        };

        ssh = {
          enable = true;
          enableDefaultConfig = false; # The default values have been rmoved
          # and instead the config below has been used.
          matchBlocks = {
            "*" = {
              forwardAgent = false;
              addKeysToAgent = "yes";
              compression = false;
              serverAliveInterval = 0;
              serverAliveCountMax = 3;
              hashKnownHosts = true;
              userKnownHostsFile = "~/.ssh/known_hosts";
              controlMaster = "no";
              controlPath = "~/.ssh/master-%r@%n:%p";
              controlPersist = "no";
            };

            "github.com" = {
              hostname = "github.com";
            };
          };
        };
      };
    };
}
