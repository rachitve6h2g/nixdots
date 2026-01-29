{
  flake.homeModules.shell =
    {
      pkgs,
      ...
    }:
    let
      ns = pkgs.writeShellScriptBin "ns" (builtins.readFile ./nixpkgs.sh);
    in
    {
      home.packages = [ ns ];
      programs = {
        direnv = {
          enable = true;
          enableBashIntegration = true;
          mise.enable = false; # If nix, why mise?
          nix-direnv.enable = true;
        };
        nix-init.enable = true;

        nh = rec {
          enable = true;
          clean = {
            enable = true;
            dates = "weekly";
            extraArgs = "--keep 4 --keep-since 3d";
          };

          # TODO Change flake paths once the nixos-config is centralized
          flake = "/home/krish/nixdots";
          homeFlake = "${flake}";
          osFlake = "${flake}";
        };

        nix-search-tv = {
          enable = true;
          enableTelevisionIntegration = true;

          settings = {
            indexes = [
              "nixpkgs"
              "home-manager"
              "nixos"
              "nur"
            ];
            update_interval = "3h2m1s";
            enable_waiting_banner = false;
          };
        };

        television = {
          enable = true;
          enableBashIntegration = true;
          # TODO: write the settings.

          settings = {
            tick_rate = 50;
            default_channel = "files";
            history_size = 200;
            global_history = false;

            ui = {
              use_nerd_font_icons = true;
              ui_scale = 120;
              show_preview_panel = false;
              # theme = "catppuccin";
              input_bar = {
                position = "top";
                prompt = ">";
                border_type = "rounded";
              };

              status_bar = {
                separator_open = "";
                separator_close = "";
                hidden = false;
              };

              results_panel = {
                border_type = "rounded";
              };

              preview_panel = {
                size = 50;
                scrollbar = true;
                border_type = "rounded";
                hidden = false;
              };

              help_panel = {
                show_categories = true;
                hidden = true;
              };

              remote_control = {
                show_channel_descriptions = true;
                sort_alphabetically = true;
              };
            };

            keybindings = {
              esc = "quit";
              "ctrl-c" = "quit";
              "ctrl-j" = "select_next_entry";
              "ctrl-k" = "select_prev_entry";
              "ctrl-p" = "select_prev_history";
              "ctrl-n" = "select_next_history";
              tab = "toggle_selection_down";
              backtab = "toggle_selection_up";
              enter = "confirm_selection";
              # Preview panel control
              # --------------------
              pagedown = "scroll_preview_half_page_down";
              pageup = "scroll_preview_half_page_up";
              # Data operations
              # --------------
              "ctrl-y" = "copy_entry_to_clipboard";
              "ctrl-r" = "reload_source";
              "ctrl-s" = "cycle_sources";
              # UI Features
              # ----------
              "ctrl-t" = "toggle_remote_control";
              "ctrl-o" = "toggle_preview";
              "ctrl-h" = "toggle_help";
              "f12" = "toggle_status_bar";

              # Input field actions
              # ----------------------------------------
              backspace = "delete_prev_char";
              "ctrl-w" = "delete_prev_word";
              "ctrl-u" = "delete_line";
              delete = "delete_next_char";
              left = "go_to_prev_char";
              right = "go_to_next_char";
              home = "go_to_input_start";
              "ctrl-a" = "go_to_input_start";
              end = "go_to_input_end";
              "ctrl-e" = "go_to_input_end";
            };

            events = {
              mouse-scroll-up = "scroll_preview_up";
              mouse-scroll-down = "scroll_preview_down";
            };
            shell_integration = {
              fallback_channel = "files";
              channel_triggers = {
                git-branch = [
                  "git checkout"
                  "git branch"
                  "git merge"
                  "git rebase"
                  "git pull"
                  "git push"
                ];
                env = [
                  "export"
                  "unset"
                ];
                git-diff = [
                  "git add"
                  "git restore"
                ];
                git-log = [
                  "git log"
                  "git show"
                ];
                docker-images = [
                  "docker run"
                ];
                git-repos = [
                  "nvim"
                  "code"
                  "hx"
                  "git clone"
                ];
                alias = [
                  "alias"
                  "unalias"
                ];
                dirs = [
                  "cd"
                  "ls"
                  "rmdir"
                ];
                files = [
                  "cat"
                  "less"
                  "head"
                  "tail"
                  "vim"
                  "nano"
                  "bat"
                  "cp"
                  "mv"
                  "rm"
                  "touch"
                  "chmod"
                  "chown"
                  "ln"
                  "tar"
                  "zip"
                  "unzip"
                  "gzip"
                  "gunzip"
                  "xz"
                ];
              };
              keybindings = {
                smart_autocomplete = "ctrl-t";
                command_history = "ctrl-r";
              };
            };
          };
        };
      };
    };
}
