{
  lib,
  config,
  pkgs,
  ...
}:
let
  userVars = {
    EDITOR = "vim";
    KITTY_ENABLE_WAYLAND = 1;
    MANPAGER = "nvim +Man!";
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
  imports = [
    ./bat.nix
    ./dircolors.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./kitty.nix
    ./readline.nix
    ./starship
    ./tealdeer.nix
    ./vivid.nix
    ./ripgrep.nix
    ./zoxide.nix
  ];

  home = {
    shell = {
      enableBashIntegration = true;
    };

    sessionVariables = userVars;

    packages = [ pkgs.wikiman ];
  };

  programs = {
    fd.enable = true;
    bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = false;

      shellAliases = {
        nixcon = "cd /etc/nixos";
        ".." = "cd ..";

        btop = "btop --force-utf";

        ff = "${pkgs.fastfetch}/bin/fastfetch";
      };
      sessionVariables = userVars;

      bashrcExtra =
        let
          interactive_dangers = # bash
            ''
              rm() { command rm -i "''${@}"; }
              cp() { command cp -i "''${@}"; }
              mv() { command mv -i "''${@}"; }
              trash() { command trash -i "''${@}"; }
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

          wikiman = /* bash */ ''
            source ${pkgs.wikiman}/share/wikiman/widgets/widget.bash
          '';
        in
        lib.mkMerge (
          [
            interactive_dangers
            wikiman
          ]
          ++ (if config.programs.yt-dlp.enable then [ yt-playlist ] else [ ])
        );
    };
  };
}
