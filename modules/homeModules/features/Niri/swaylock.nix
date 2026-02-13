{
  flake.homeModules.swaylock =
    { pkgs, ... }:
    {
      programs.swaylock = {
        enable = true;
        package = pkgs.swaylock-effects;

        settings = {
          clock = true;
          font-size = 25;
          effect-blur = "7x5";
          daemonize = true;
          timestr = "%I:%M:%S %p";
          indicator-radius = 100;
        };
      };
    };
}
