{
  pkgs,
  lib,
  config,
  ...
}:
let
  myAliases = {
    gocon = "cd $HOME/.dotfiles";

    # Get image on the fly.
    kitcat = "${pkgs.kitty}/bin/kitten icat";

    # For btop, coz the l18n is set to indian
    btop = "btop --force-utf";
    # Jump to the git source dir.
    cdg = "cd $(git rev-parse --show-toplevel)";

    # For audio downloading
    yt-music = "yt-dlp -x -f bestaudio --audio-format mp3 -o '~/Music/%(artist)s/%(album)s/%(title)s.%(ext)s'";

    ".." = "cd ..";
    ffetch = "${pkgs.fastfetch}/bin/fastfetch";
  };
in
{
  imports = [ ./eza.nix ];

  home = {
    shell.enableZshIntegration = true;
    sessionVariables = config.programs.zsh.sessionVariables;
  };

  programs = {
    # All the shellIntegration options
    kitty.shellIntegration.enableZshIntegration = true;
    zoxide.enableZshIntegration = true;
    yazi.enableZshIntegration = true;
    starship.enableZshIntegration = true;
    nix-index.enableZshIntegration = true;
    fzf.enableZshIntegration = true;
    eza.enableZshIntegration = true;

    zsh = {
      enable = true;

      sessionVariables = {
        MOZ_ENABLE_WAYLAND = 1;
        QT_QPA_PLATFORM = "wayland";
        SUDO_PROMPT = lib.concatStrings [
          "$(tput setaf 1 bold)󰌾 "
          "$(tput sgr0)$(tput setaf 2) password"
          "$(tput sgr0)$(tput setaf 4) for"
          "$(tput sgr0)$(tput setaf 5) %p"
          "$(tput sgr0)$(tput setaf 3):"
        ];
      };

      initContent =
        let
          interactive_functions =
            lib.mkAfter
              # bash
              ''
                rm() { command rm -i "''${@}"; }
                cp() { command cp -i "''${@}"; }
                mv() { command mv -i "''${@}"; }
                trash() { command trash -i "''${@}"; }
              '';

          extract_function =
            lib.mkAfter
              # bash
              ''
                extract() {
                  if [ -f $1 ]; then
                    case $1 in
                     *.tar.bz2) tar xvjf $1 ;;
                     *.tar.gz) tar xvzf $1 ;;
                     *.bz2) bunzip2 $1 ;;
                     *.rar) unrar x $1 ;;
                     *.gz) gunzip $1 ;;
                     *.tar) tar xvf $1 ;;
                     *.tbz2) tar xvjf $1 ;;
                     *.tgz) tar xvzf $1 ;;
                     *.zip) unzip $1 ;;
                     *.Z) uncompress $1 ;;
                     *.7z) 7z x $1 ;;
                     *) echo "don't know how to extract '$1'..." ;;
                    esac
                  else
                    echo "'$1' is not a valid file!"
                  fi
                }
              '';
          lazy_git_change_dir =
            lib.mkAfter
              # bash
              ''
                lg()
                  {
                      export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

                      lazygit "$@"

                      if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
                              cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
                              rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
                      fi
                  }
              '';
        in
        lib.mkMerge [
          interactive_functions
          extract_function
          lazy_git_change_dir
        ];

      # Don't forget to add
      # environment.pathsToLink = [ "/share/zsh" ];
      # to configuration.nix
      enableCompletion = true;

      autosuggestion = {
        enable = true;
        strategy = [
          "completion"
        ];
      };

      syntaxHighlighting = {
        enable = true;
        styles = with config.lib.stylix.colors.withHashtag; {
          comment = "fg=${base04}";
          alias = "fg=${base0B}";
          suffix-alias = "fg=${base0B}";
          global-alias = "fg=${base0B}";
          function = "fg=${base0B}";
          command = "fg=${base0B}";
          precommand = "fg=${base0B},italic";
          autodirectory = "fg=${base09},italic";
          single-hyphen-option = "fg=${base09}";
          double-hyphen-option = "fg=${base09}";
          back-quoted-argument = "fg=${base0E}";

          builtin = "fg=${base0B}";
          reserved-word = "fg=${base0B}";
          hashed-command = "fg=${base0B}";

          commandseperator = "fg=${base08}";
          command-substitution-delimiter = "fg=${base05}";
          command-substitution-delimiter-unquoted = "fg=${base05}";
          process-substitution-delimiter = "fg=${base05}";
          back-quoted-argument-delimiter = "fg=${base08}";
          back-double-quoted-argument = "fg=${base08}";
          back-dollar-quoted-argument = "fg=${base08}";

          command-substitution-quoted = "fg=${base0A}";
          command-substitution-delimiter-quoted = "fg=${base0A}";
          single-quoted-argument = "fg=${base0A}";
          single-quoted-argument-unclosed = "fg=${base08}";
          double-quoted-argument = "fg=${base0A}";
          double-quoted-argument-unclosed = "fg=${base08}";
          rc-quote = "fg=${base0A}";

          dollar-quoted-argument = "fg=${base05}";
          dollar-quoted-argument-unclosed = "fg=${base08}";
          dollar-double-quoted-argument = "fg=${base05}";
          assign = "fg=${base05}";
          named-fd = "fg=${base05}";
          numeric-fd = "fg=${base05}";

          unknown-token = "fg=${base08}";
          path = "fg=${base05},underline";
          path_pathseparator = "fg=${base08},underline";
          globbing = "fg=${base05}";
          history-expansion = "fg=${base0E}";
          back-quoted-argument-unclosed = "fg=${base08}";
          redirection = "fg=${base05}";
          arg0 = "fg=${base05}";
          default = "fg=${base05}";
          cursor = "fg=${base05}";
        };
      };

      dotDir = ".config/zsh";

      # TODO: set up the history attribute

      # Use the home.shellAliases for simple shell aliases.
      # If there are shell specific aliases, use this.
      shellAliases = myAliases;
    };
  };
}
