{
  flake.homeModules.hyprlauncher =
    { pkgs, ... }:
    {
      services = {
        hyprlauncher = {
          enable = true;
          settings = {
            desktop_launch_prefix = "${pkgs.app2unit}/bin/app2unit --";
            cache = {
              enabled = true;
            };
            finders = {
              desktop_icons = true;
              math_prefix = "=";
            };
            general = {
              grab_focus = true;
            };
            ui = {
              window_size = "400 260";
            };
          };
        };
      };
    };
}
