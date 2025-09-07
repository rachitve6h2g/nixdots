{
  # pkgs,
  lib,
  config,
  ...
}:
{
  # Set a different hyprlock wallpaper.
  # stylix.targets.hyprlock.useWallpaper = false;

  programs = {
    hyprlock = {
      enable = true;

      sourceFirst = true;
      importantPrefixes = [
        "$"
        "bezier"
        "size"
        "monitor"
      ];

      settings = with config.lib.stylix.colors; {
        "$font" = "Monospace";
        animations = {
          enabled = true;
          bezier = [
            "linear, 1, 1, 0, 0"
          ];

          animation = [
            "fadeIn, 1, 5, linear"
            "fadeOut, 1, 5, linear"
            "inputFieldDots, 1, 2, linear"
          ];
        };

        general = {
          hide_cursor = false;
        };

        background = {
          # path =
          #   let
          #     wallpaper = pkgs.fetchurl {
          #       url = "https://github.com/AngelJumbo/gruvbox-wallpapers/blob/main/wallpapers/anime/anime_skull.png?raw=true";
          #       hash = "sha256-cI8tgi0ADVpvWbk+8tTKA+4RmV1pdLNLfCdc5EUxQj4=";
          #     };
          #   in
          #   "${wallpaper}";
          blur_passes = 3;
          blur_size = 8;
        };

        input-field = {
          monitor = "";
          size = "20%, 5%";
          outline_thickness = 3;
          # inner_color = <managed by stylix>
          outer_color = lib.mkForce "rgba(${base0D}ee) rgba(${base0E}ee) 45deg";
          check_color = lib.mkForce "rgba(${base0B}ee) rgba(${base0C}ee) 120deg";
          fail_color = lib.mkForce "rgba(${base08}ee) rgba(${base09}ee) 40deg";

          # font_color = "rgb(143, 143, 143)";
          fade_on_empty = false;
          rounding = 15;

          font_family = "$font";
          placeholder_text = "Input password...";
          fail_text = "$PAMFAIL";

          dots_spacing = 0.3;

          position = "0, -20";
          halign = "center";
          valign = "center";
        };

        label = [
          # TIME
          {
            monitor = "";
            text = "$TIME12";
            font_size = 90;
            font_family = "$font";

            position = "-30, 0";
            halign = "right";
            valign = "top";
          }

          # DATE
          {
            monitor = "";
            text = "cmd[update:60000] date +\"%A, %d %B %Y\"";
            font_size = 25;
            font_family = "$font";
            position = "-30, -150";
            halign = "right";
            valign = "top";
          }
        ];
      };
    };
  };
}
