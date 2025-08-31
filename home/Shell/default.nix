{ lib, ... }:
{
  imports = [
    ./bat.nix
    ./fish.nix
    ./fzf.nix
    # ./nushell.nix
    ./readline.nix
    ./ripgrep.nix
    ./zoxide.nix
    # ./zsh.nix

    ./starship
  ];

  home = {
    sessionVariables = {
      EDITOR = "nvim";
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
  };

  programs = {
    nix-index = {
      enable = true;
    };

    fd = {
      enable = true;
      hidden = true;
    };
  };
}
