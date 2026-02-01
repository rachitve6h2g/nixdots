{
  flake.homeModules.avizo =
    { pkgs, ... }:
    {

      home.packages = with pkgs; [
        brightnessctl
        pamixer
      ];

      services.avizo = {
        enable = true;

        settings = {
          default = {
            time = 1.0;
            fade-in = 0.1;
            fade-out = 0.2;
            y-offset = 0.5;
            padding = 10;
          };
        };
      };
    };
}
