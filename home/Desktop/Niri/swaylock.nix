{ pkgs, ... }:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      clock = true;
      image = "~/.dotfiles/hosts/core/Desktop/anime_skull.png";
      effect-blur = "7x5";
      daemonize = true;
    };
  };
}
