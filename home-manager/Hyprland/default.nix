{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}:
{
  imports = [
    ./clipboard.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprsunset.nix
    ./mako.nix
    ./poweralertd.nix
    ./theme.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home = {
    packages = with pkgs; [ app2unit ];
  };

  services.playerctld.enable = true;

  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  programs = {
    hyprshot = {
      enable = true;
      # Saves screenshots into the $XDG_PICTURES_DIR/Screenshot directory.
      saveLocation = "${config.xdg.userDirs.pictures}/Screenshot";
    };
  };

  wayland.windowManager = with config.lib.stylix.colors; {
    hyprland = {
      enable = true;

      # Cannot be set to null like told in the Hyprland wiki, because of
      # hyprsunset
      package = osConfig.programs.hyprland.package;
      portalPackage = osConfig.programs.hyprland.portalPackage;

      sourceFirst = true;
      systemd = {
        enable = false;
      };
      xwayland.enable = false;

      importantPrefixes = [
        "$"
        "bezier"
        "name"
        "output"
      ];

      plugins = with pkgs.hyprlandPlugins; [
        hyprexpo
        hypr-dynamic-cursors
      ];

      settings = {
        plugin = {
          hyprexpo = {
            columns = 3;
            gap_size = 5;
            bg_col = "rgb(000000)";
            workspace_method = "first 1";
            enable_gesture = true;
            gesture_fingers = 3;
            gesture_distance = 300;
            gesture_positive = false;
          };

          dynamic-cursors = {
            hyprcursor = {
              enabled = true;
            };
          };
        };

        monitor = [
          "eDP-1,1920x1080@60.05600,0x0,1"
          "HDMI-A-1,1920x1080@120.00,1920x0,1"
        ];

        "$terminal" = "${pkgs.app2unit}/bin/app2unit -T";
        "$menu" = "${pkgs.wofi}/bin/wofi --show drun";
        "$filemanager" = "${pkgs.app2unit}/bin/app2unit yazi.desktop";

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          # styling would be set by stylix
          "col.active_border" = lib.mkForce "rgba(${base0D}ee) rgba(${base0E}ee)";
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 18;
          rounding_power = 5;

          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            ignore_window = true;
            range = 10;
            render_power = 3;
          };

          blur = {
            enabled = true;
            xray = true;
            special = false;
            new_optimizations = true;
            size = 14;
            passes = 3;
            brightness = 1;
            noise = 0.01;
            contrast = 1;
            popups = true;
            popups_ignorealpha = 0.6;
            input_methods = true;
            input_methods_ignorealpha = 0.8;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;

          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];

          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
          force_split = 2;
        };

        master = {
          new_status = "master";
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;

          enable_swallow = true;
          swallow_regex = "kitty";
        };

        input = {
          kb_layout = "us";
          kb_variant = "colemak_dh";
          kb_options = "caps:swapescape";
          numlock_by_default = true;

          follow_mouse = 1;
          off_window_axis_events = 2;
          sensitivity = 0;

          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
            clickfinger_behavior = true;
            scroll_factor = 0.5;
          };
        };

        cursor = {
          zoom_factor = 1;
          zoom_rigid = false;
        };

        gestures = {
          workspace_swipe = true;
        };

        "$mod" = "SUPER";

        bind = [
          "$mod, Return, exec, exec $terminal"
          "$mod, Q, killactive,"
          "$mod, M, exec, loginctl-terminate user \"\""
          "$mod, T, exec, $filemanager"
          "$mod, V, togglefloating,"
          "$mod, R, exec, $menu"
          "$mod, P, pseudo, # dwindle"
          "$mod, E, togglesplit, # dwindle"
          "$mod, F, fullscreen, 0"
          "$modSHIFT, F, fullscreen, 1"

          # focus with mod + arrow keys
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          # Move windows around in the same workspace
          "$modSHIFT, h, movewindow, l"
          "$modSHIFT, l, movewindow, r"
          "$modSHIFT, k, movewindow, u"
          "$modSHIFT, j, movewindow, d"

          # Special workspace (scratchpad)
          "$mod, S, togglespecialworkspace, magic"
          "$modSHIFT, S, movetoworkspace, special:magic"

          # Scroll through existing workspaces with mod + scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # For hyprexpo plugin
          "$mod, O, hyprexpo:expo, toggle"

          # For hyprshot screenshot
          "$mod, PRINT, exec, hyprshot -m window" # For a window
          ", PRINT, exec, hyprshot -m output"
          "$modSHIFT, PRINT, exec, hyprshot -m region"
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

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        bindel =
          let
            brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
          in
          [
            # Laptop multimedia keys for volume and LCD brightness
            ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 0.9 @DEFAULT_AUDIO_SINK@ 5%+"
            ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ",XF86MonBrightnessUp, exec, ${brightnessctl} -e4 -n2 set 5%+"
            ",XF86MonBrightnessDown, exec, ${brightnessctl} -e4 -n2 set 5%-"
          ];

        bindl =
          let
            playerctl = "${pkgs.playerctl}/bin/playerctl";
          in
          [
            # Requires playerctl
            ", XF86AudioNext, exec, ${playerctl} next"
            ", XF86AudioPause, exec, ${playerctl} play-pause"
            ", XF86AudioPlay, exec, ${playerctl} play-pause"
            ", XF86AudioPrev, exec, ${playerctl} previous"
          ];
        windowrule = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];
      };
    };
  };
  stylix.image = pkgs.fetchurl {
    url = "https://github.com/rachitve6h2g/Wallpapers/blob/main/platform.jpg?raw=true";
    hash = "sha256-ZQsr2w8vzwPrWvaU7sAE69d8ouetpwe8nkBKeIGx58U=";
  };
}
