{ pkgs, config, ... }:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      clock = true;
      # image = "${config.stylix.image}";
      effect-blur = "7x5";
      daemonize = true;
    };
  };
}
