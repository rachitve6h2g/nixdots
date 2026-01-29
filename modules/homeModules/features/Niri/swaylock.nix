{
  flake.homeModules.niri =
    { pkgs, ... }:
    {
      programs.swaylock = {
        enable = true;
        package = pkgs.swaylock-effects;

        settings = {
          clock = true;
          effect-blur = "7x5";
          daemonize = true;
          timestr = "%I:%M:%S %p";
          indicator-radius = 70;
        };
      };
    };
}
