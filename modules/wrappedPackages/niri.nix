{ self, ... }:
let
  inherit (self) theme;
in
{
  flake.wrappers.niri =
    {
      wlib,
      pkgs,
      lib,
      ...
    }:
    let
      mkMenu =
        menu:
        let
          configFile = pkgs.writeText "config.yaml" (
            with theme;
            lib.generators.toYAML { } {
              # A little bit of style
              font = "Iosevka Nerd Font";
              background = "${base00}d0";
              color = "${base05}";
              border = "${base09}";
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
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      # apply = true;
      imports = [ wlib.wrapperModules.niri ];
      passthru = {
        providedSessions = [ "niri" ];
      };
      filesToPatch = [
        "share/wayland-sessions/*.desktop"
        "share/applications/*.desktop"
        "share/systemd/user/niri.service"
        "share/systemd/user/*.target"
      ];
      settings =
        let
          noctalia = cmd: "noctalia-shell ipc call ${cmd}";
        in
        with theme;
        {
          spawn-at-startup = [ "${pkgs.lib.getExe (self.wrappers.noctalia-shell.wrap { inherit pkgs; })}" ];
          input = {
            keyboard = {
              xkb = {
                layout = "us";
                variant = "colemak_dh";
                options = "caps:swapescape";
              };
              repeat-delay = 600;
              repeat-rate = 25;
              track-layout = "global";
            };
            touchpad = {
              tap = null;
              dwt = null;
              dwtp = null;
              natural-scroll = null;
            };

            warp-mouse-to-focus = null;
            focus-follows-mouse._attrs = {
              max-scroll-amount = "0%";
            };
            workspace-auto-back-and-forth = null;
          };
          clipboard.disable-primary = null;
          hotkey-overlay.skip-at-startup = null;

          animations = rec {
            config-notification-open-close = {
              spring._attrs = {
                damping-ratio = 1.0;
                epsilon = 0.001;
                stiffness = 1000;
              };
            };

            horizontal-view-movement = config-notification-open-close;
            overview-open-close = {
              spring._attrs = {
                damping-ratio = 1.0;
                epsilon = 0.001;
                stiffness = 900;
              };
            };
            screenshot-ui-open = {
              duration-ms = 300;
              curve = "ease-out-quad";
            };
            window-close = {
              duration-ms = 200;
              curve = "ease-out-cubic";
            };
            window-movement = config-notification-open-close;
            window-open = {
              duration-ms = 200;
              curve = "ease-out-quad";
            };
            workspace-switch = config-notification-open-close;
          };
          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
          debug.honor-xdg-activation-with-invalid-serial = null;

          outputs = {
            eDP-1 = {
              focus-at-startup = null;
              transform = "normal";
              mode = "1920x1080@60.056";
            };
          };

          prefer-no-csd = null;
          overview.workspace-shadow.off = null;

          cursor = {
            xcursor-theme = "Bibata-Modern-Ice";
            xcursor-size = 24;
          };

          binds = {
            "Mod+G".spawn-sh = noctalia "launcher clipboard"; # Clipboard
            "Mod+D".spawn-sh = noctalia "launcher toggle"; # Launcher

            "Mod+E".spawn-sh = "Thunar";

            "Mod+F".spawn-sh = pkgs.lib.getExe (mkMenu [
              {
                key = "f";
                desc = "Firefox";
                cmd = "firefox"; # TODO: See how to get the wrapped firefox output
              }
              {
                key = "d";
                desc = "Vesktop";
                cmd = "vesktop";
              }
            ]);

            "Mod+Return".spawn = [ "${lib.getExe selfpkgs.wezterm}" ];

            "Mod+Q".close-window = null;
            "Mod+BracketLeft".consume-or-expel-window-left = null;
            "Mod+BracketRight".consume-or-expel-window-right = null;

            "Mod+Comma".consume-window-into-column = null;
            "Mod+Period".expel-window-from-column = null;

            # "Mod+R".action = set-preset-column-width;
            "Mod+Shift+R".switch-preset-window-height = null;
            "Mod+Ctrl+R".reset-window-height = null;

            "Mod+M".maximize-window-to-edges = null;
            "Mod+Shift+M".maximize-column = null;
            "Mod+Ctrl+M".expand-column-to-available-width = null;

            "Mod+C".center-column = null;

            "Mod+Minus".set-column-width = "-10%";
            "Mod+Equal".set-column-width = "+10%";

            "Mod+Shift+Minus".set-window-height = "-10%";
            "Mod+Shift+Equal".set-window-height = "+10%";

            "Mod+V".toggle-window-floating = null;
            "Mod+Shift+V".switch-focus-between-floating-and-tiling = null;

            "Mod+W".toggle-column-tabbed-display = null;

            "Mod+Space".switch-layout = "next";
            "Mod+Shift+Space".switch-layout = "prev";

            "Print".screenshot = [ ];
            "Ctrl+Print".screenshot-screen = [ ];
            "Alt+Print".screenshot-window = [ ];

            "Mod+Shift+Ctrl+E".quit = null;

            "Mod+O".toggle-overview = null;

            XF86AudioRaiseVolume = {
              spawn-sh = noctalia "volume increase";
              _attrs.allow-when-locked = true;
            };
            XF86AudioLowerVolume = {
              spawn-sh = noctalia "volume decrease";
              _attrs.allow-when-locked = true;
            };
            XF86AudioMute = {
              spawn-sh = noctalia "volume muteOutput";
              _attrs.allow-when-locked = true;
            };
            XF86MonBrightnessUp = {
              spawn-sh = noctalia "brightness increase";
              _attrs.allow-when-locked = true;
            };
            XF86MonBrightnessDown = {
              spawn-sh = noctalia "brightness decrease";
              _attrs.allow-when-locked = true;
            };
            XF86AudioNext = {
              spawn-sh = noctalia "media next";
              _attrs.allow-when-locked = true;
            };
            XF86AudioPause = {
              spawn-sh = noctalia "media playPause";
              _attrs.allow-when-locked = true;
            };
            XF86AudioPlay = {
              spawn-sh = noctalia "media playPause";
              _attrs.allow-when-locked = true;
            };
            XF86AudioPrev = {
              spawn-sh = noctalia "media previous";
              _attrs.allow-when-locked = true;
            };

            # Move around windows in a workspace using vim keys.
            # Vim movement keys are easier, since using the mod key
            # is easier with vim keys
            "Mod+H".focus-column-left-or-last = null;
            "Mod+L".focus-column-right-or-first = null;
            "Mod+K".focus-window-or-workspace-up = null;
            "Mod+J" = {
              focus-window-or-workspace-down = null;
            };

            # Move windows/columns around in a workspace
            "Mod+Shift+H".move-column-left = null;
            "Mod+Shift+L".move-column-right = null;
            "Mod+Shift+K".move-window-up-or-to-workspace-up = null;
            "Mod+Shift+J".move-window-down-or-to-workspace-down = null;
          }
          //
            # Change workspaces using Mod+<1-0>
            (builtins.listToAttrs (
              builtins.genList (
                i:
                let
                  n = i + 1;
                  key = if n == 10 then "Mod+0" else "Mod+${toString n}";
                in
                {
                  name = key;
                  value.focus-workspace = n;
                }
              ) 10
            ));

          layout = {
            gaps = 12;
            focus-ring.off = null;
            border = {
              width = 3;
              active-gradient = {
                _attrs = {
                  angle = 45;
                  from = "${base0E}";
                  "in" = "oklch shorter hue";
                  relative-to = "workspace-view";
                  to = "${base0D}";
                };
              };
              inactive-color = "${base02}";
            };
            background-color = "transparent";
            center-focused-column = "on-overflow";
            always-center-single-column = null;
            empty-workspace-above-first = null;

            preset-column-widths = [
              { proportion = 1. / 3.; }
              { proportion = 1. / 2.; }
              { proportion = 2. / 3.; }
            ];

            default-column-width.proportion = 0.5;

            shadow = {
              on = null;
              offset = {
                _attrs = {
                  x = 0;
                  y = 5;
                };
              };
              softness = 30;
              spread = 5;
              draw-behind-window = false;
              color = "#00000070";
            };

            tab-indicator = {
              gap = 5.0;
              width = 4.0;
              length = {
                _attrs = {
                  total-proportion = 0.5;
                };
              };
              position = "top";
              gaps-between-tabs = 10;
              corner-radius = 0.0;
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
                [
                  r
                  r
                  r
                  r
                ];
              clip-to-geometry = true;
            }

            {
              matches = [ { is-floating = true; } ];
              geometry-corner-radius =
                let
                  r = 15.0;
                in
                [
                  r
                  r
                  r
                  r
                ];
            }

            {
              matches = [
                {
                  # app-id = "firefox$";
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
              shadow.off = null;
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
                fixed = 1030;
              };
              default-window-height = {
                fixed = 160;
              };
            }

            {
              matches = [
                { app-id = "^emacs.*"; }
                { app-id = "firefox$"; } # Maximize Firefox
                { app-id = "vesktop$"; }
              ];
              open-maximized-to-edges = true;
            }
          ];
        };
    };
}
