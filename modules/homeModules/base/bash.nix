{ lib, ... }:
{
  flake.homeModules.shell =
    { pkgs, config, ... }:
    let
      userVars = {
        KITTY_ENABLE_WAYLAND = 1;
        GTK_THEME = "adw-gtk3";
        MOZ_ENABLE_WAYLAND = 1;
        SUDO_PROMPT = lib.concatStrings [
          "$(tput bold)"
          "$(tput setaf 5)"
          "[🔒 SUDO]$(tput sgr0) "
          "$(tput bold)$(tput setaf 6)"
          "Password for "
          "$(tput setaf 3)"
          "$USER$(tput sgr0): "
        ];
      };
    in
    {
      programs = {
        info.enable = false;
        pandoc.enable = true;

        fzf = {
          enable = true;

          enableBashIntegration = true;
          defaultOptions = [
            "--height 40%"
            "--border"
          ];

          fileWidgetCommand = "fd --type file --type directory --hidden --exclude .git";
          fileWidgetOptions = [ "--preview='${lib.getExe pkgs.fzf-preview}'" ];

          changeDirWidgetCommand = "fd --type directory --hidden --exclude .git";

          # Default command that is executed for fzf - $FZF_DEFAULT_COMMAND
          defaultCommand = "fd --type file --hidden --exclude .git";
        };
        eza = {
          enable = true;

          git = true;
          icons = "auto";
          colors = "auto";

          enableBashIntegration = true;
          extraOptions = [
            "--group-directories-first"
            "--header"
            "--git-repos"
            "--group"
          ];
        };

        fd = {
          enable = true;
          hidden = true;
        };

        vivid = {
          enable = true;
          enableBashIntegration = true;
          colorMode = "24-bit";
        };

        readline = {
          enable = true;
          includeSystemConfig = true;
          variables = {
            expand-tilde = true;
            completion-ignore-case = true;
            show-all-if-ambiguous = true;
            colored-stats = true;
            visible-stats = true;
            mark-symlinked-directories = true;
            colored-completion-prefix = true;
          };
        };

        ripgrep-all = {
          enable = true;
        };
        ripgrep.enable = true;

        tealdeer = {
          enable = true;
          enableAutoUpdates = true;

          settings = {
            display = {
              compact = false;
              use_pager = true;
            };
            updates = {
              auto_update = true;
              auto_update_interval_hours = 24;
            };
          };
        };

        zoxide = {
          enable = true;
          enableBashIntegration = true;
        };
      };

      # Shell Configuration
      home = {
        shell = {
          enableBashIntegration = true;
        };
        sessionVariables = userVars;
        packages = [
          pkgs.trashy
          pkgs.fzf-preview
        ];
      };

      programs.bash = {
        enable = true;
        enableCompletion = true;
        enableVteIntegration = false;

        historyIgnore = [
          "ls"
          "cd"
          "exit"
        ];

        historySize = 100000;
        historyFileSize = 10000;

        shellOptions = lib.mkAfter [
          "cdspell"
          "histappend"
          "extglob"
          "globstar"
          "checkjobs"
        ];

        shellAliases = {
          nixcon = "cd /etc/nixos";
          ".." = "cd ..";

          # btop = "btop --force-utf";

          kava = "kitten panel --edge=background --override background_opacity=0.0 cava";
          tp = "${pkgs.trashy}/bin/trash put";
        };
        sessionVariables = userVars;

        initExtra = ''
          		# Just an eye candy
          		${pkgs.microfetch}/bin/microfetch
        '';

        bashrcExtra =
          let
            interactive_dangers = # bash
              ''
                rm() { command rm -i "''${@}"; }
                cp() { command cp -i "''${@}"; }
                mv() { command mv -i "''${@}"; }
              '';

            yt-playlist = /* bash */ ''
              yt-playlist() {
                yt-dlp \
                    --ignore-errors \
                    --continue \
                    --no-overwrites \
                    --download-archive progress.txt \
                    "$@"
              }
            '';

            yt-music = # bash
              ''
                yt-music() {
                  yt-dlp \
                  -x \
                  -f bestaudio \
                  "$@"
                }
              '';
          in
          lib.mkMerge (
            [
              interactive_dangers
            ]
            ++ (
              if config.programs.yt-dlp.enable then
                [
                  yt-playlist
                  yt-music
                ]
              else
                [ ]
            )
          );
      };
    };
}
