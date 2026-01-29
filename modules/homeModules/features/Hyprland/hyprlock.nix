{
  flake.homeModules.hyprland =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/rachitve6h2g/Wallpapers/main/Shinchan.png";
        hash = "sha256-CP9uGyslZ19wCaglMb1UG+NmcU/GxN5HDXSdrO5jAlw=";
      };
      colors = config.lib.stylix.colors;
    in
    {
      programs = {
        hyprlock = {
          enable = true;

          settings = lib.mkAfter {
            "$font" = "Monospace";

            general = {
              hide_cursor = true;
              ignore_empty_input = true;
            };

            animations = {
              enabled = true;
              bezier = "linear, 1, 1, 0, 0";
              animation = [
                "fadeIn, 1, 5, linear"
                "fadeOut, 1, 5, linear"
                "inputFieldDots, 1, 2, linear"
              ];
            };

            background = {
              monitor = "";
              # path = "screenshot";
              blur_passes = 3;
            };

            image = {
              monitor = "";
              path = "${image}";
              size = 200;
              rounding = -1;
              position = "0, 200";
              halign = "center";
              valign = "center";
            };

            input-field = lib.mkAfter {
              monitor = "";
              size = "20%, 5%";
              outline_thickness = 3;
              fade_on_empty = true;
              rounding = 15;

              placeholder_text = "Only The Worthy...";
              fail_text = "$PAMFAIL";
              font_family = "$font";

              dots_spacing = 0.3;
              hide_input = true;
              position = "0, -20";
              halign = "center";
              valign = "center";

              inner_color = lib.mkForce "rgba(${colors.base00}aa)";
            };

            label = [
              {
                monitor = "";
                text = "$TIME12"; # ref. https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/#variable-substitution
                font_size = 90;
                font_family = "$font";

                position = "-30, 0";
                halign = "right";
                valign = "top";
              }

              # DATE
              {
                monitor = "";
                text = "cmd[update:60000] date \+\"%A, %d %B %Y\""; # update every 60 seconds
                font_size = 25;
                font_family = "$font";

                position = "-30, -150";
                halign = "right";
                valign = "top";
              }

              {
                monitor = "";
                text = "$LAYOUT[us]";
                font_size = 24;
                onclick = "${pkgs.hyprland}/bin/hyprctl switchxkblayout all next";

                position = "250, -20";
                halign = "center";
                valign = "center";
              }
            ];
          };
        };
      };
    };
}
