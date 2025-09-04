{ osConfig, ... }:
{
  programs = {
    nh = rec {
      enable = true;
      clean = osConfig.programs.nh.clean;
      flake = osConfig.programs.nh.flake;
      homeFlake = "${flake}";
      osFlake = "${flake}";
    };
  };
}
