{
  flake.homeModules.waybar =
    {
      lib,
      pkgs,
      ...
    }:
    {
      programs = {
        waybar = {
          enable = true;

          package = pkgs.waybar;

          systemd = {
            enable = true;
            # target = ; # Set the same as wayland.systemd.target
            enableDebug = true;
            # enableInspect = true;
          };

          settings = {
            mainBar = {
              reload_style_on_change = true;
              layer = "top";
              position = "bottom";
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
              "niri/workspaces" = {
                on-click = "activate";
                format = "{icon}";
                format-icons = {
                  default = "";
                  "1" = "1";
                  "2" = "2";
                  "3" = "3";
                  "4" = "4";
                  "5" = "5";
                  "6" = "6";
                  "7" = "7";
                  "8" = "8";
                  "9" = "9";
                  active = "󱓻";
                };
                persistent-workspaces = {
                  "1" = [

                  ];
                  "2" = [

                  ];
                  "3" = [

                  ];
                  "4" = [

                  ];
                  "5" = [

                  ];
                };
              };
              cpu = {
                interval = 5;
                format = "󰍛";
                on-click = "kitty -e btop";
              };
              clock = {
                format = "{:%A %I:%M %p}";
                format-alt = "{:%d %B W%V %Y}";
                tooltip = false;
                on-click-right = "kitty -e clock-rs";
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
                spacing = 1;
                on-click = "sh -c \"kitten quick-access-terminal impala\"";
              };
              battery = rec {
                format = "{capacity}% {icon}";
                format-discharging = format;
                format-charging = format;
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
                # on-click = "omarchy-menu power";
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
                on-click = "sh -c \"kitten quick-access-terminal bluetui\"";
              };
              idle_inhibitor = {
                format = "{icon}";
                format-icons = {
                  activated = "";
                  deactivated = "";
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
              pulseaudio = {
                format = "{icon}";
                on-click = "sh -c \"kitten quick-access-terminal wiremix\"";
                on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
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
                #clock,
                #idle_inhibitor {
                  min-width: 12px;
                  margin: 0 7.5px;
                }

                #idle_inhibitor.activated {
                  color: @base08;
                }

                #custom-expand-icon {
                  margin-right: 12px;
                }

                tooltip {
                  padding: 2px;
                }
              '';
        };
      };
    };
}
