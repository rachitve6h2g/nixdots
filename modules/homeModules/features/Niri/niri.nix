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

      mkMenu =
        menu:
        let
          configFile = pkgs.writeText "config.yaml" (
            lib.generators.toYAML { } {
              # A little bit of style
              font = "${config.stylix.fonts.monospace.name}";
              background = "${colors.base00}d0";
              color = "${colors.base05}";
              border = "${colors.base09}";
              separator = " ➜ ";
              border_width = 2;
              corner_r = 10;
              padding = 15;
              anchor = "bottom-right";
              inherit menu;
            }
          );

        in
        pkgs.writeShellScriptBin "my-menu" ''
          exec ${lib.getExe pkgs.wlr-which-key} ${configFile}
        '';
    in
    {
      imports = [
        # If you're using Home-Manager as a NixOS
        # Module, comment the these modules
        inputs.niri.homeModules.stylix
        inputs.niri.homeModules.niri

        self.homeModules.swayidle
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
            hotkey-overlay.skip-at-startup = true;

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
                  options = "ctrl:swapcaps"; # When using vim
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

            spawn-at-startup = [
              {
                sh = "${pkgs.pipewire}/bin/pw-play --volume 0.5 ${pkgs.kdePackages.ocean-sound-theme}/share/sounds/ocean/stereo/desktop-login.oga";
              }
            ];

            binds =
              with config.lib.niri.actions;
              let
                noctalia = cmd: "noctalia-shell ipc call ${cmd}";
              in
              {
                # Open the clipboard
                "Mod+G".action.spawn-sh = noctalia "launcher clipboard";

                /*
                  "Mod+D" = {
                    action.spawn-sh = pkgs.lib.getExe (mkMenu [
                      {
                        key = "m";
                        desc = "Menu";
                        cmd = noctalia "launcher toggle";
                      }
                    ]);
                  };
                */

                "Mod+D".action.spawn-sh = noctalia "launcher toggle";

                # Filemanagers
                "Mod+E".action.spawn-sh = pkgs.lib.getExe (mkMenu [
                  {
                    key = "t";
                    desc = "Thunar";
                    cmd = "Thunar";
                  }

                  /*
                    {
                      key = "e";
                      desc = "Emacs Dirvish";
                      cmd = "${config.programs.emacs.package}/bin/emacsclient -n -c -e '(progn (select-frame-set-input-focus (selected-frame)) (dirvish))'";
                    }
                  */
                ]);

                "Mod+F".action.spawn-sh = pkgs.lib.getExe (mkMenu [
                  {
                    key = "f";
                    desc = "Firefox";
                    cmd = "firefox";
                  }

                  {
                    key = "d";
                    desc = "Vesktop";
                    cmd = "vesktop";
                  }
                ]);

                "Mod+Return".action.spawn-sh = pkgs.lib.getExe (mkMenu [
                  {
                    key = "e";
                    desc = "Emacsclient";
                    cmd = "${config.programs.emacs.package}/bin/emacsclient -a \"emacs\" -c";
                  }
                  {
                    key = "t";
                    desc = "Terminal";
                    cmd = "footclient"; # TODO: Change to foot
                  }
                ]);

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

                # TODO: set to maximize-window-to-edges.
                # It's still not implemented in sodiboo/niri-flake.
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
                  action.spawn-sh = noctalia "volume increase";
                  allow-when-locked = true;
                };
                XF86AudioLowerVolume = {
                  action.spawn-sh = noctalia "volume decrease";
                  allow-when-locked = true;
                };
                XF86AudioMute = {
                  action.spawn-sh = noctalia "volume muteOutput";
                  allow-when-locked = true;
                };
                XF86MonBrightnessUp = {
                  # action = brightness "5%+";

                  action.spawn-sh = noctalia "brightness increase";

                  allow-when-locked = true;
                };
                XF86MonBrightnessDown = {
                  action.spawn-sh = noctalia "brightness decrease";
                  allow-when-locked = true;
                };
                XF86AudioNext = {
                  action.spawn-sh = noctalia "media next";
                  allow-when-locked = true;
                };
                XF86AudioPause = {
                  action.spawn-sh = noctalia "media playPause";
                  allow-when-locked = true;
                };
                XF86AudioPlay = {
                  action.spawn-sh = noctalia "media playPause";
                  allow-when-locked = true;
                };
                XF86AudioPrev = {
                  action.spawn-sh = noctalia "media previous";
                  allow-when-locked = true;
                };

                # Move around windows in a workspace using vim keys.
                # Vim movement keys are easier, since using the mod key
                # is easier with vim keys
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
                width = 3;

                active.gradient = {
                  from = colors.base0E;
                  to = colors.base0D;
                  angle = 45;
                  in' = "oklch shorter hue";
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
                  # Using the noctalia wallpaper setting.
                  {
                    namespace = "^noctalia-wallpaper*";
                  }
                  {
                    namespace = "^noctalia-desktop-widgets*";
                  }
                  {
                    namespace = "kitty-panel";
                  }
                ];
                place-within-backdrop = true;
              }
            ];

            window-rules = [
              {
                draw-border-with-background = false;
                # Enable rounded borders
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
                    app-id = "(?i).*thunar.*";
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

              {
                matches = [
                  { app-id = "^emacs*"; }
                  { app-id = "firefox$"; } # Maximize Firefox
                  { app-id = "vesktop$"; }
                ];
                # TODO: Set open-maximized to open-maximized-to-edges
                # See https://github.com/niri-wm/niri/wiki/Fullscreen-and-Maximize
                open-maximized = true;
              }
            ];

            clipboard.disable-primary = true;
            overview = {
              # zoom = 0.5;
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
              # Also allows notification actions and window activation from Noctali
              honor-xdg-activation-with-invalid-serial = [ ];
            };
          };
        };
      };
    };
}
