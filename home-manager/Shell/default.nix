{
  lib,
  config,
  pkgs,
  ...
}:
let
  userVars = {
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
  }
  // (if config.services.emacs.defaultEditor then { } else { EDITOR = "vim"; });
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
    ./vivid.nix
    ./ripgrep.nix
    ./zoxide.nix
  ];

  home = {
    shell = {
      enableBashIntegration = true;
    };

    sessionVariables = userVars;
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
        speedtest = "nix run nixpkgs#speedtest-cli -- --secure";

        ff = "${pkgs.fastfetch}/bin/fastfetch";
      }
      // (if config.programs.emacs.enable then { ec = "emacsclient -c"; } else { });
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
        in
        lib.mkMerge [
          interactive_dangers
        ];
    };
  };
}
