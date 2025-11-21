{
  config,
  lib,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors.withHashtag;
in
{
  imports = [
    ./avizo.nix
    ./clipboard.nix
    # ./fuzzel.nix
    ./mako.nix
    ./niriswitcher.nix
    ./polkit.nix
    ./poweralertd.nix
    ./quickshell.nix # NOTE: learn nix first, lisp second and then qml
    ./swayidle.nix
    ./swaylock.nix
    ./theme.nix
    # ./walker.nix
    ./wallpaper.nix
    ./waybar.nix
    ./wlsunset.nix
    ./wofi.nix

    ./xdg-portal.nix
  ];

  home = {
    packages = with pkgs; [
      brightnessctl
    ];
  };

  # qmlls will not be able to pick up qml modules that are not in QML2_IMPORT_PATH.
  # The easiest way to ensure this is by setting qt.enable to true
  # and installing the quickshell package globally.
  qt.enable = true;

  services.playerctld.enable = true;

  wayland.systemd.target = "graphical-session.target";

  programs = {
    niri = {
      package = null;
      settings = {
        prefer-no-csd = true;

        # Available for next version.
        xwayland-satellite = {
          enable = true;
          path = lib.getExe pkgs.xwayland-satellite;
        };

        spawn-at-startup = [
          {
            # For starting niriswitcher
            command = [ "${pkgs.niriswitcher}/bin/niriswitcher" ];
          }
        ];
        input = {
          keyboard = {
            xkb = {
              layout = "us";
              variant = "colemak_dh";
              # options = "ctrl:swapcaps";
              options = "caps:swapescape";
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
          workspace-auto-back-and-forth = true;
          warp-mouse-to-focus = {
            enable = true;
          };
        };

        outputs = {
          "eDP-1" = {
            enable = true;
            focus-at-startup = true;
            mode = {
              refresh = 60.056;
              width = 1980;
              height = 1080;
            };
          };
        };

        binds =
          with config.lib.niri.actions;
          let
            sh = spawn "sh" "-c";
          in
          {
            "Mod+D" = {
              action = spawn [
                "wofi"
                "--show"
                "drun"
              ];
              hotkey-overlay.title = "Run an Application: wofi";
            };

            "Mod+T" = {
              action = spawn [
                "kitty"
              ];
              hotkey-overlay.title = "Spawn Kitty Terminal";
            };

            "Mod+Q" = {
              action = close-window;
            };

            # Move around windows in a workspace using vim keys.
            "Mod+H".action = focus-column-left;
            "Mod+L".action = focus-column-right;
            "Mod+K".action = focus-window-up;
            "Mod+J".action = focus-window-down;

            # Move the windows around in a workspace.
            "Mod+Ctrl+H".action = move-column-left;
            "Mod+Ctrl+L".action = move-column-right;
            "Mod+Ctrl+K".action = move-window-up;
            "Mod+Ctrl+J".action = move-window-down;

            "Mod+E".action = focus-column-last;
            "Mod+A".action = focus-column-first;

            "Mod+U".action = focus-workspace-down;
            "Mod+I".action = focus-workspace-up;

            "Mod+Shift+U".action = move-column-to-workspace-down;
            "Mod+Shift+I".action = move-column-to-workspace-up;

            "Mod+Ctrl+U".action = move-workspace-down;
            "Mod+Ctrl+I".action = move-workspace-up;

            "Mod+1".action = focus-workspace 1;
            "Mod+2".action = focus-workspace 2;
            "Mod+3".action = focus-workspace 3;
            "Mod+4".action = focus-workspace 4;
            "Mod+5".action = focus-workspace 5;
            "Mod+6".action = focus-workspace 6;
            "Mod+7".action = focus-workspace 7;
            "Mod+8".action = focus-workspace 8;
            "Mod+9".action = focus-workspace 9;
            "Mod+0".action = focus-workspace 10;

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

            "Print".action.screenshot = [ ];
            "Ctrl+Print".action.screenshot-screen = [ ];
            "Alt+Print".action.screenshot-window = [ ];

            "Mod+Shift+E".action = quit;

            "Mod+G".action = sh "cliphist list | wofi -S dmenu | cliphist decode | wl-copy";

            "Mod+O".action = toggle-overview;

            "Mod+X".action = spawn "fuzzel-powermenu";

            XF86AudioRaiseVolume = {
              action = spawn [
                # "wpctl"
                # "set-volume"
                # "@DEFAULT_AUDIO_SINK@"
                # "3%+"
                # "-l"
                # "1.0"

                "volumectl"
                "-u"
                "up"
              ];
              allow-when-locked = true;
            };
            XF86AudioLowerVolume = {
              action = spawn [
                # "wpctl"
                # "set-volume"
                # "@DEFAULT_AUDIO_SINK@"
                # "3%-"
                "volumectl"
                "-u"
                "down"
              ];
              allow-when-locked = true;
            };
            XF86AudioMute = {
              action = spawn [
                # "wpctl"
                # "set-mute"
                # "@DEFAULT_AUDIO_SINK@"
                # "toggle"
                "volumectl"
                "toggle-mute"
              ];
              allow-when-locked = true;
            };
            XF86MonBrightnessUp = {
              action = spawn [
                # "brightnessctl"
                # "-e4"
                # "-n2"
                # "set"
                # "5%+"
                #
                "lightctl"
                "up"
              ];
              allow-when-locked = true;
            };
            XF86MonBrightnessDown = {
              action = spawn [
                # "brightnessctl"
                # "-e4"
                # "-n2"
                # "set"
                # "5%-"
                "lightctl"
                "down"
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

            # For niriswitcher
            "Alt+Tab" = {
              repeat = false;
              action = spawn [
                "${pkgs.glib}/bin/gdbus"
                "call"
                "--session"
                "--dest"
                "io.github.isaksamsten.Niriswitcher"
                "--object-path"
                "/io/github/isaksamsten/Niriswitcher"
                "--method"
                "io.github.isaksamsten.Niriswitcher.application"
              ];
            };
            "Alt+Grave" = {
              repeat = false;
              action = spawn [
                "${pkgs.glib}/bin/gdbus"
                "call"
                "--session"
                "--dest"
                "io.github.isaksamsten.Niriswitcher"
                "--object-path"
                "/io/github/isaksamsten/Niriswitcher"
                "--method"
                "io.github.isaksamsten.Niriswitcher.application"
              ];
            };
          };

        layout = {
          gaps = 16;

          # struts = {
          #   left = 64;
          #   right = 64;
          # };

          background-color = "transparent";
          center-focused-column = "on-overflow";
          always-center-single-column = true;
          empty-workspace-above-first = true;

          preset-column-widths = [
            { proportion = 1. / 3.; }
            { proportion = 1. / 2.; }
            { proportion = 2. / 3.; }
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
            softness = 30;
            spread = 5;
            offset = {
              x = 0;
              y = 5;
            };
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
                r = 20.0;
              in
              {
                top-left = r;
                top-right = r;
                bottom-right = r;
                bottom-left = r;
              };

            clip-to-geometry = true;
          }

          {
            matches = [
              {
                app-id = "r#\"firefox$\"";
                title = "^Picture-in-Picture$";
              }
            ];
            open-floating = true;
          }
        ];

        clipboard.disable-primary = true;
        overview = {
          zoom = 0.5;
          workspace-shadow = {
            enable = false;
          };
        };

        animations = {
          workspace-switch = {
            enable = true;
            kind.spring = {
              damping-ratio = 1.0;
              stiffness = 1000;
              epsilon = 0.0001;
            };
          };

          window-open = {
            enable = true;
            kind.easing = {
              duration-ms = 200;
              curve = "ease-out-quad";
            };
          };

          window-close = {
            enable = true;
            kind.easing = {
              duration-ms = 200;
              curve = "ease-out-cubic";
            };
          };
          horizontal-view-movement = {
            enable = true;
            kind.spring = {
              damping-ratio = 1.0;
              stiffness = 1000;
              epsilon = 0.0001;
            };
          };
          window-movement = {
            enable = true;
            kind.spring = {
              damping-ratio = 1.0;
              stiffness = 1000;
              epsilon = 0.0001;
            };
          };
          window-resize = {
            enable = true;
            kind.spring = {
              damping-ratio = 1.0;
              stiffness = 1000;
              epsilon = 0.0001;
            };
            custom-shader = builtins.readFile ./resize.glsl;
          };

          config-notification-open-close = {
            enable = true;
            kind.spring = {
              damping-ratio = 1.0;
              stiffness = 1000;
              epsilon = 0.001;
            };
          };

          screenshot-ui-open = {
            enable = true;
            kind.easing = {
              duration-ms = 300;
              curve = "ease-out-quad";
            };
          };

          overview-open-close = {
            enable = true;
            kind.spring = {
              damping-ratio = 1.0;
              stiffness = 900;
              epsilon = 0.0001;
            };
          };
        };
      };
    };
  };
}
