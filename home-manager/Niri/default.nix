{
  config,
  # inputs,
  # lib,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors.withHashtag;
in
{
  # Use only when using separate home-manager config.
  /*
    imports = [
      inputs.niri-flake.homeModules.niri
      inputs.niri-flake.homeModules.stylix
    ];

    nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
  */

  imports = [
    ./clipboard.nix
    ./fuzzel.nix
    ./mako.nix
    ./poweralertd.nix
    ./swayidle.nix
    ./swaylock.nix
    ./theme.nix
    ./wallpaper.nix
    ./waybar.nix
  ];

  home = {
    packages = with pkgs; [
      brightnessctl
      app2unit
    ];
  };

  xdg.configFile = {
    "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

    "uwsm/env-niri".text = ''
      export APP2UNIT_SLICES='a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice'
    '';
  };

  services.playerctld.enable = true;

  programs = {
    niri = {
      package = null;
      settings = {
        prefer-no-csd = true;

        # Available for next version.
        /*
          xwayland-sattellite = {
            enable = true;
            path = lib.getExe pkgs.xwayland-satellite;
          };
        */

        spawn-at-startup = [
          {
            command = [
              "uwsm"
              "finalize"
            ];
          }
        ];
        input = {
          keyboard = {
            xkb = {
              layout = "us";
              variant = "colemak_dh";
              options = "ctrl:nocaps";
            };
          };
          touchpad = {
            tap = true;
            dwt = true;
            dwtp = true;
            natural-scroll = true;
          };

          focus-follows-mouse = {
            enable = true;
            max-scroll-amount = "0%";
          };
        };

        binds = with config.lib.niri.actions; {
          "Mod+D" = {
            action = spawn "fuzzel";
            hotkey-overlay.title = "Run an Application: fuzzel";
          };

          "Mod+Return" = {
            action = spawn [
              "app2unit"
              "-T"
            ];
            hotkey-overlay.title = "Spawn Kitty Terminal";
          };

          "Mod+Q" = {
            action = close-window;
          };

          "Mod+N".action = focus-window-down-or-column-right;
          "Mod+P".action = focus-window-up-or-column-left;

          "Mod+Ctrl+B".action = move-column-left;
          "Mod+Ctrl+N".action = move-window-down;
          "Mod+Ctrl+P".action = move-window-up;
          "Mod+Ctrl+F".action = move-column-right;

          "Mod+Shift+N".action = move-window-down;
          "Mod+Shift+P".action = move-window-up;

          "Mod+E".action = focus-column-last;
          "Mod+A".action = focus-column-first;

          "Mod+U".action = focus-workspace-down;
          "Mod+I".action = focus-workspace-up;

          "Mod+Shift+U".action = move-column-to-workspace-down;
          "Mod+Shift+I".action = move-column-to-workspace-up;

          "Mod+Ctrl+U".action = move-workspace-down;
          "Mod+Ctrl+I".action = move-workspace-up;

          "Mod+1".action = focus-workspace 1;
          # "Mod+Ctrl+1".action = move-column-to-workspace 1;

          "Mod+BracketLeft".action = consume-or-expel-window-left;
          "Mod+BracketRight".action = consume-or-expel-window-right;

          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;

          # "Mod+R".action = set-preset-column-width;
          "Mod+Shift+R".action = switch-preset-window-height;
          "Mod+Ctrl+R".action = reset-window-height;
          "Mod+M".action = maximize-column;
          "Mod+Shift+M".action = fullscreen-window;
          "Mod+Ctrl+M".action = expand-column-to-available-width;

          "Mod+C".action = center-column;

          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";

          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          "Mod+V".action = toggle-window-floating;
          "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

          "Mod+W".action = toggle-column-tabbed-display;

          "Mod+Space".action = switch-layout "next";
          "Mod+Shift+Space".action = switch-layout "prev";

          "Print".action = screenshot;
          "Ctrl+Print".action.screenshot-screen = [ ];
          "Alt+Print".action = screenshot-window;

          "Mod+Shift+E".action = quit;

          "Mod+G".action = spawn "clipboard";

          "Mod+O".action = toggle-overview;

          "Mod+X".action = spawn "fuzzel-powermenu";

          XF86AudioRaiseVolume = {
            action = spawn [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "3%+"
              "-l"
              "1.0"
            ];
            allow-when-locked = true;
          };
          XF86AudioLowerVolume = {
            action = spawn [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "3%-"
            ];
            allow-when-locked = true;
          };
          XF86AudioMute = {
            action = spawn [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SINK@"
              "toggle"
            ];
            allow-when-locked = true;
          };
          XF86MonBrightnessUp = {
            action = spawn [
              "brightnessctl"
              "s"
              "5%+"
            ];
            allow-when-locked = true;
          };
          XF86MonBrightnessDown = {
            action = spawn [
              "brightnessctl"
              "s"
              "5%-"
            ];
            allow-when-locked = true;
          };
          XF86AudioNext = {
            action = spawn [
              "playerctl"
              "next"
            ];
            allow-when-locked = true;
          };
          XF86AudioPause = {
            action = spawn [
              "playerctl"
              "play-pause"
            ];
            allow-when-locked = true;
          };
          XF86AudioPlay = {
            action = spawn [
              "playerctl"
              "play-pause"
            ];
            allow-when-locked = true;
          };
          XF86AudioPrev = {
            action = spawn [
              "playerctl"
              "previous"
            ];
            allow-when-locked = true;
          };
        };

        layout = {
          gaps = 30;
          background-color = "transparent";
          center-focused-column = "on-overflow";
          always-center-single-column = true;
          empty-workspace-above-first = true;

          preset-column-widths = [
            # { fixed = 1920; }
          ];

          default-column-width = {
            proportion = 0.5;
          };

          border = {
            width = 3;

            active.gradient = {
              from = colors.base0A;
              to = colors.base0D;
              angle = 45;
              in' = "oklab";
              relative-to = "workspace-view";
            };
          };

          shadow = {
            enable = true;
          };

          tab-indicator = {
            position = "top";
            gaps-between-tabs = 10;
          };
        };

        layer-rules = [
          {
            matches = [
              {
                namespace = "^wallpaper$";
              }
            ];
            place-within-backdrop = true;
          }
        ];

        window-rules = [
          {
            draw-border-with-background = false;
            geometry-corner-radius =
              let
                r = 8.0;
              in
              {
                top-left = r;
                top-right = r;
                bottom-right = r;
                bottom-left = r;
              };

            clip-to-geometry = true;
          }
        ];

        clipboard.disable-primary = true;
        overview = {
          zoom = 0.5;
          workspace-shadow = {
            enable = false;
          };
        };

        animations.window-resize.custom-shader = builtins.readFile ./resize.glsl;
      };
    };
  };
}
