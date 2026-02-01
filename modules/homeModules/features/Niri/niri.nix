{ inputs, self, ... }:
{
  flake.homeModules.niri =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      colors = config.lib.stylix.colors.withHashtag;
    in
    {
      imports = [
        # If you're using Home-Manager as a NixOS
        # Module, comment the these modules
        inputs.niri.homeModules.stylix
        inputs.niri.homeModules.niri

        # Modules to use with niri
        self.homeModules.avizo
        self.homeModules.fuzzel
        self.homeModules.swayidle
        self.homeModules.swaylock
        self.homeModules.waybar
        self.homeModules.wbg
        self.homeModules.wlsunset
      ];

      services.gnome-keyring = {
        enable = true;
        components = [ "ssh" ];
      };

      wayland.systemd.target = "graphical-session.target";
      xdg.portal = {
        enable = true;
        configPackages = [ config.programs.niri.package ];
        extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
        # See https://wiki.nixos.org/wiki/Niri#File_picker_not_working
        config.niri = {
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        };
      };

      programs = {
        niri = {
          enable = true;
          # make sure that programs.niri.package
          # is set to the same.
          package = pkgs.niri;
          settings = {
            prefer-no-csd = true;

            # Available for next version.
            xwayland-satellite = {
              enable = true;
              path = lib.getExe pkgs.xwayland-satellite;
            };

            input = {
              keyboard = {
                xkb = {
                  layout = "us";
                  variant = "colemak_dh";
                  # options = "ctrl:swapcaps"; # When using Emacs
                  options = "caps:swapescape"; # When using neovim
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
              "HDMI-A-1" = {
                enable = true;
                mode = {
                  refresh = 120.000;
                  width = 1920;
                  height = 1080;
                };
              };
            };

            binds =
              with config.lib.niri.actions;
              let
                # sound = spawn "wpctl" "set-volume" "-l" "1" "@DEFAULT_AUDIO_SINK@";
                playerctl = spawn "playerctl";
                # brightness = spawn "brightnessctl" "-e4" "-n2" "set";
              in
              {
                "Mod+D" = {
                  action = spawn [
                    "${pkgs.fuzzel}/bin/fuzzel"
                  ];
                  hotkey-overlay.title = "Run an Application: vicinae";
                };

                "Mod+G" = {
                  action = spawn [
                    "${pkgs.cliphist}/bin/cliphist-fuzzel-img"
                  ];
                  hotkey-overlay.title = "Open clipboard";
                };

                "Mod+Return" = {
                  action = spawn [
                    "kitty"
                  ];
                  hotkey-overlay.title = "Spawn Kitty Terminal";
                };

                # "Mod+Shift+Return" = {
                #   action = spawn [
                #     "emacsclient"
                #     "-a \"\""
                #     "-c"
                #   ];

                #   hotkey-overlay.title = "Spawn Emacsclient";
                # };

                "Mod+Q" = {
                  action = close-window;
                };

                # TODO: These can be used to work with multi-monior setup
                # "Mod+U".action = focus-workspace-down;
                # "Mod+I".action = focus-workspace-up;

                # "Mod+Shift+U".action = move-column-to-workspace-down;
                # "Mod+Shift+I".action = move-column-to-workspace-up;

                # "Mod+Ctrl+U".action = move-workspace-down;
                # "Mod+Ctrl+I".action = move-workspace-up;

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

                "Mod+Shift+Ctrl+E".action = quit;

                "Mod+O".action = toggle-overview;

                XF86AudioRaiseVolume = {
                  # action = sound "5%+";
                  action = spawn [
                    "volumectl"
                    "-u"
                    "up"
                  ];

                  allow-when-locked = true;
                };
                XF86AudioLowerVolume = {
                  # action = sound "5%-";
                  action = spawn [
                    "volumectl"
                    "-u"
                    "down"
                  ];

                  allow-when-locked = true;
                };
                XF86AudioMute = {
                  /*
                    action = spawn [
                      "wpctl"
                      "set-mute"
                      "@DEFAULT_AUDIO_SINK@"
                      "toggle"
                    ];
                  */

                  action = spawn [
                    "volumectl"
                    "toggle-mute"
                  ];

                  allow-when-locked = true;
                };
                XF86MonBrightnessUp = {
                  # action = brightness "5%+";

                  action = spawn [
                    "lightctl"
                    "up"
                  ];

                  allow-when-locked = true;
                };
                XF86MonBrightnessDown = {
                  # action = brightness "5%-";

                  action = spawn [
                    "lightctl"
                    "down"
                  ];
                  
                  allow-when-locked = true;
                };
                XF86AudioNext = {
                  action = playerctl "next";
                  allow-when-locked = true;
                };
                XF86AudioPause = {
                  action = playerctl "play-pause";
                  allow-when-locked = true;
                };
                XF86AudioPlay = {
                  action = playerctl "play-pause";
                  allow-when-locked = true;
                };
                XF86AudioPrev = {
                  action = playerctl "play-pause";
                  allow-when-locked = true;
                };

                # Move around windows in a workspace using vim keys.
                "Mod+H".action = focus-column-left-or-last;
                "Mod+L".action = focus-column-right-or-first;
                "Mod+K".action = focus-window-or-workspace-up;
                "Mod+J".action = focus-window-or-workspace-down;

                # Move windows/columns around in a workspace
                "Mod+Shift+H".action = move-column-left;
                "Mod+Shift+L".action = move-column-right;
                "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
                "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
              };

            layout = {
              gaps = 12;

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
                width = 2;

                active.gradient = {
                  from = colors.base0E;
                  to = colors.base0D;
                  angle = 45;
                  in' = "oklab";
                  relative-to = "workspace-view";
                };
                inactive.color = colors.base02;
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
                  {
                    namespace = "kitty-panel";
                  }
                  {
                    namespace = "ashell-main-layer";
                  }
                ];
                place-within-backdrop = true;
              }
            ];

            window-rules = [
              {
                draw-border-with-background = false;
                # Enable rounded borders
                # geometry-corner-radius =
                #   let
                #     r = 15.0;
                #   in
                #   {
                #     top-left = r;
                #     top-right = r;
                #     bottom-right = r;
                #     bottom-left = r;
                #   };

                clip-to-geometry = true;
              }

              {
                matches = [ { is-floating = true; } ];
                geometry-corner-radius =
                  let
                    r = 15.0;
                  in
                  {
                    top-left = r;
                    top-right = r;
                    bottom-right = r;
                    bottom-left = r;
                  };
              }

              {
                matches = [
                  {
                    app-id = "firefox$";
                    title = "^Picture-in-Picture$";
                  }
                ];
                open-floating = true;
                default-column-width = {
                  fixed = 480;
                };
                default-window-height = {
                  fixed = 270;
                };
              }

              {
                matches = [ { is-floating = false; } ];
                shadow.enable = false;
              }

              # Open thunar in floating
              {
                matches = [
                  {
                    app-id = "thunar$";
                    title = ".*Thunar.*";
                  }

                  {
                    app-id = "thunar$";
                    title = ".*File Operation Progress.*";
                  }
                ];
                open-floating = true;
                default-column-width = {
                  fixed = 1029;
                };
                default-window-height = {
                  fixed = 683;
                };
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

            debug = {
              # Activate focus on the window that opens from vicinae
              honor-xdg-activation-with-invalid-serial = [ ];
            };
          };
        };
      };
    };
}
