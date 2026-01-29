{ self, ... }:
{
  flake.homeModules.hyprland =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [
        self.homeModules.hypridle
        self.homeModules.hyprlauncher
        self.homeModules.hyprlock
        self.homeModules.hyprsunset
      ];
      xdg = {
        portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
        configFile = {
          "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
          "uwsm/env-hyprland".text = ''
            export HYPRLAND_TRACE=1

            export HYPRLAND_NO_RT=1
            export HYPRLAND_NO_SD_NOTIFY=1
            export HYPRLAND_NO_SD_VARS=1

            export AQ_DRM_DEVICES=/dev/dri/card1

            export HYPRCURSOR_THEME="${config.stylix.cursor.name}"
            export HYPRCURSOR_SIZE="${toString config.stylix.cursor.size}"
          '';
        };
      };

      # Adding to the packages list anyways.
      home.packages = with pkgs; [ hyprtoolkit ];

      wayland.windowManager.hyprland = {
        enable = true;

        # Systemd conflicts with hyprland's
        # UWSM integration.
        systemd.enable = false;

        plugins = with pkgs.hyprlandPlugins; [
          hyprexpo
        ];

        importantPrefixes = [
          "$"
          "$mod"
          "bezier"
          "monitor"
          "name"
          "output"
        ];

        settings = {
          "$mod" = "SUPER";
          "$terminal" = "${pkgs.app2unit}/bin/app2unit-term";
          "$menu" = "${pkgs.vicinae}/bin/vicinae toggle";

          plugin = {
            hyprexpo = {
              columns = 2;
              gap_size = 5;
              bg_col = "rgb(111111)";
              workspace_method = "center current";
              gesture_distance = 300;
            };
          };

          monitor = [
            " , preferred, auto, 1"
          ];

          bind = [
            "$mod, Q, killactive,"
            "$modSHIFT, E, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"

            "$mod, V, togglefloating,"
            "$mod, L, pseudo," # dwindle
            "$mod, J, togglesplit," # dwindle

            # Binds for plugins

            # Hyprexpo
            "$mod, O, hyprexpo:expo, toggle"

            # Move focus around in a single workspace
            "$mod, B, movefocus, l"
            "$mod, F, movefocus, r"
            "$mod, P, movefocus, u"
            "$mod, N, movefocus, d"

            # Same as above +Shift to move windows
            # in a single workspace
            "$modSHIFT, B, movewindow, l"
            "$modSHIFT, F, movewindow, r"
            "$modSHIFT, P, movewindow, u"
            "$modSHIFT, N, movewindow, d"

            "$mod, M, fullscreen, 1" # Maximize window
            "$modSHIFT, M, fullscreen, 0" # occupy the fullscreen

            "$mod, T, exec, $terminal"
            "$mod, Return, exec, ${pkgs.emacs-pgtk}/bin/emacsclient -a \"\" -c"

            "$mod, D, exec, $menu"

            ", Print, exec, grimblast copy area"

            "$mod, mouse_down, workspace, e+1"
            "$mod, mouse_up, workspace, e-1"

            "$mod, I, workspace, e+1" # Use keybinds to toggle
            "$mod SHIFT, I, workspace, e-1" # workspaces

            "$mod, S, togglespecialworkspace, magic"
            "$mod SHIFT, S, movetoworkspace, special:magic"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (
              builtins.genList (
                i:
                let
                  ws = i + 1;
                in
                [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              ) 9
            )
          );

          bindl = [
            ", XF86AudioNext, exec, playerctl next"
            ", XF86AudioPause, exec, playerctl play-pause"
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioPrev, exec, playerctl previous"
          ];

          bindel = [
            ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
            ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%+"
            ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -e4 -n2 set 5%-"
          ];

          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];

          ecosystem = {
            enforce_permissions = 1;
          };

          exec-once = [
            # Play a login sound
            "${pkgs.pipewire}/bin/pw-play --volume 0.5 ${pkgs.kdePackages.ocean-sound-theme}/share/sounds/ocean/stereo/desktop-login.oga"
          ];

          permission = [
            "${config.wayland.windowManager.hyprland.portalPackage}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
            "${lib.escapeRegex (lib.getExe config.programs.hyprlock.package)}, screencopy, allow"
            "${pkgs.hyprlandPlugins.hyprexpo}/lib/libhyprexpo.so, plugin, allow"
          ];

          input = {
            kb_layout = "us";
            kb_variant = "colemak_dh";
            kb_options = "ctrl:swapcaps";
            follow_mouse = 1;
            sensitivity = 0;

            touchpad = {
              natural_scroll = true;
            };
          };

          gestures = {
            workspace_swipe_create_new = true;
          };

          gesture = [
            "3, horizontal, workspace"
          ];

          general = {
            gaps_in = 3;
            gaps_out = 15;

            border_size = 2;

            resize_on_border = false;
            layout = "dwindle";
          };

          decoration = {
            rounding = 10;
            rounding_power = 2;

            # Change transparency of focused and unfocused windows
            active_opacity = 1.0;
            inactive_opacity = 1.0;

            shadow = {
              enabled = true;
              range = 4;
              render_power = 3;
            };

            # https://wiki.hypr.land/Configuring/Variables/#blur
            blur = {
              enabled = true;
              size = 3;
              passes = 1;

              vibrancy = 0.1696;
            };
          };

          animations = {
            enabled = true;
            bezier = [
              # Default curves, see https://wiki.hypr.land/Configuring/Animations/#curves
              # NAME,           X0,   Y0,   X1,   Y1
              "easeOutQuint,   0.23, 1,    0.32, 1"
              "easeInOutCubic, 0.65, 0.05, 0.36, 1"
              "linear,         0,    0,    1,    1"
              "almostLinear,   0.5,  0.5,  0.75, 1"
              "quick,          0.15, 0,    0.1,  1"
            ];

            animation = [
              # Default animations, see https://wiki.hypr.land/Configuring/Animations/
              # NAME,         ONOFF, SPEED, CURVE,        [STYLE]
              "global,        1,     10,    default"
              "border,        1,     5.39,  easeOutQuint"
              "windows,       1,     4.79,  easeOutQuint"
              "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
              "windowsOut,    1,     1.49,  linear,       popin 87%"
              "fadeIn,        1,     1.73,  almostLinear"
              "fadeOut,       1,     1.46,  almostLinear"
              "fade,          1,     3.03,  quick"
              "layers,        1,     3.81,  easeOutQuint"
              "layersIn,      1,     4,     easeOutQuint, fade"
              "layersOut,     1,     1.5,   linear,       fade"
              "fadeLayersIn,  1,     1.79,  almostLinear"
              "fadeLayersOut, 1,     1.39,  almostLinear"
              "workspaces,    1,     1.94,  almostLinear, fade"
              "workspacesIn,  1,     1.21,  almostLinear, fade"
              "workspacesOut, 1,     1.94,  almostLinear, fade"
              "zoomFactor,    1,     7,     quick"
            ];
          };

          dwindle = {
            pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mod + P in the keybinds section below
            preserve_split = true; # You probably want this
          };

          # See https://wiki.hypr.land/Configuring/Master-Layout/ for more
          master = {
            new_status = "master";
          };

          misc = {
            focus_on_activate = true;
          };

          layerrule = [
            {
              name = "vicinae-blur";
              blur = "on";
              ignore_alpha = 0;
              "match:namespace" = "vicinae";
            }

            {
              name = "vicinae-no-animation";
              no_anim = "on";
              "match:namespace" = "vicinae";
            }
          ];

          windowrule = [
            {
              name = "suppress-maximize-events";
              "match:class" = ".*";
              suppress_event = "maximize";
            }

            {
              # Fix some dragging issues with XWayland
              name = "fix-xwayland-drags";
              "match:class" = "^$";
              "match:title" = "^$";
              "match:xwayland" = true;
              "match:float" = true;
              "match:fullscreen" = false;
              "match:pin" = false;

              no_focus = true;
            }

            {
              name = "move-hyprland-run";
              "match:class" = "hyprland-run";
              move = "20 monitor_h-120";
              float = "yes";
            }
          ];

        };

        hyprtoolkit = {
          package = pkgs.hyprtoolkit;
          settings = {
            background = "0xFF181818";
            base = "0xFF202020";
            text = "0xFFDADADA";
            alternate_base = "0xFF";
            bright_text = "0xFF";
            accent = "0xFF";
            accent_secondary = "0xFF";
            h1_size = 19;
            h2_size = 15;
            h3_size = 13;
            font_size = 11;
            small_font_size = 10;
            icon_theme = "${config.stylix.icons.light}";
            font_family = "${config.stylix.fonts.sansSerif.name}";
            font_family_monospace = "${config.stylix.fonts.monospace.name}";
            rounding_large = 10;
            rounding_small = 5;
          };
        };
      };
    };
}
