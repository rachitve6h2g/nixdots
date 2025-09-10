{
  config,
  lib,
  pkgs,
  ...
}:
{

  programs = {
    fuzzel = {
      enable = true;

      package = pkgs.fuzzel.override { svgBackend = "librsvg"; };

      settings = {
        main = {
          terminal = "kitty";
          font = lib.mkForce "monospace:size=11";
          icon-theme = config.stylix.iconTheme.light;
          placeholder = "  Enter App Name";
          prompt = "󱡴  ";
          use-bold = "yes";
          layer = "overlay";
          launch-prefix = "app2unit --fuzzel-compat --";
        };
      };
    };
  };
}
