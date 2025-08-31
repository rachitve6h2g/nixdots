{
  lib,
  pkgs,
  ...
}:
{
  programs.waybar = {
    enable = true;

    package = (
      pkgs.waybar.override {
        evdevSupport = false;
        gpsSupport = false;
        mpdSupport = false;
        mprisSupport = false;
        niriSupport = true;
      }
    );

    systemd = {
      enable = true;
    };

    settings = {
      mainBar = {
        reload_style_on_change = true;
        layer = "top";
        position = "top";
        spacing = 0;
        height = 26;
        modules-left = [
          "idle_inhibitor"
          "niri/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "group/tray-expander"
          "bluetooth"
          "network"
          "pulseaudio"
          "cpu"
          "battery"
        ];
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };
        cpu = {
          interval = 5;
          format = "󰍛";
          on-click = "kitty -e 'btop --force-utf'";
        };
        clock = {
          format = "{:%A %H:%M}";
          format-alt = "{:%d %B W%V %Y}";
          tooltip = false;
        };
        network = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 3;
          nospacing = 1;
          on-click = "kitty --class=Impala -e impala";
        };
        battery = {
          format = "{capacity}% {icon}";
          format-discharging = "{icon} {capacity}%";
          format-charging = "{icon} {capacity}%";
          format-plugged = "";
          format-icons = {
            charging = [
              "󰢜"
              "󰂆"
              "󰂇"
              "󰂈"
              "󰢝"
              "󰂉"
              "󰢞"
              "󰂊"
              "󰂋"
              "󰂅"
            ];
            default = [
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };
          format-full = "󰂅";
          tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
          tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
          interval = 5;
          states = {
            warning = 20;
            critical = 10;
          };
        };
        bluetooth = {
          format = "";
          format-disabled = "󰂲";
          format-connected = "";
          tooltip-format = "Devices connected: {num_connections}";
          on-click = "kitty -e bluetuith";
        };
        pulseaudio = {
          format = "{icon}";
          on-click = "kitty --class=Wiremix -e wiremix";
          on-click-right = "pamixer -t";
          tooltip-format = "Playing at {volume}%";
          scroll-step = 5;
          format-muted = "󰝟";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
        };
        "group/tray-expander" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 600;
            children-class = "tray-group-item";
          };
          modules = [
            "custom/expand-icon"
            "tray"
          ];
        };
        "custom/expand-icon" = {
          format = " ";
          tooltip = false;
        };
        tray = {
          icon-size = 12;
          spacing = 12;
        };
      };
    };

    # Managed by stylix
    style =
      lib.mkAfter # css
        ''
          * {
            background-color: @base00;
            color: @base05;

            border: none;
            border-radius: 0;
            min-height: 0;
            font-family: monospace;
            font-size: 12px;
          }

          .modules-left {
            margin-left: 8px;
          }

          .modules-right {
            margin-right: 8px;
          }

          #workspaces button {
            all: initial;
            padding: 0 6px;
            margin: 0 1.5px;
            min-width: 9px;
          }

          #workspaces button.empty {
            opacity: 0.5;
          }

          #tray,
          #cpu,
          #battery,
          #network,
          #bluetooth,
          #pulseaudio,
          #clock {
            min-width: 12px;
            margin: 0 7.5px;
          }

          #custom-expand-icon {
            margin-right: 12px;
          }

          tooltip {
            padding: 2px;
          }
        '';
  };
}
