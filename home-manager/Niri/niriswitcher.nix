{
  programs = {
    niriswitcher = {
      enable = true;
      settings = {
        keys = {
          switch = {
            prev = "Shift+Tab";
            next = "Tab";
          };
          window = {
            close = "q";
            abort = "Escape";
          };
          workspace = {
            next = "grave";
            prev = "Shift+asciitilde";
          };
          modifier = "Alt_L";
        };
        separate_workspaces = true;
        current_output_only = false;
        center_on_focus = false;
        appearance = {
          max_width = 800;
          min_width = 600;
          system_theme = "dark";
          workspace_format = "{output}-{idx}";
          animation = {
            reveal = {
              hide_duration = 200;
              show_duration = 200;
              easing = "ease-out-cubic";
            };
            resize = {
              duration = 200;
              easing = "ease-in-out-cubic";
            };
            workspace = {
              duration = 200;
              transition = "slide";
            };
            switch = {
              duration = 200;
              easing = "ease-out-cubic";
            };
          };
          icon_size = 128;
        };
        double_click_to_hide = false;
        log_level = "WARN";
        workspace = {
          mru_sort_in_workspace = false;
          mru_sort_across_workspace = true;
        };
      };

      style = # css
        ''
          :root {
            --bg-color: rgba(28, 28, 30, .95);
            --label-color: rgb(209, 209, 214);
            --alternate-label-color: rgb(229, 229, 234);
            --dim-label-color: rgb(142, 142, 147);
            --border-color: rgba(72, 72, 74, .95);
            --highlight-color: rgba(99,99,102,0.95);
            --urgency-color: rgb(255, 69, 58);
            --indicator-focus-color: rgba(10, 132, 255, 0.95);
            --indicator-color: rgba(58, 58, 60, .95);
          }

          #niriswitcher.background {
              background-color: transparent;
          }

          #niriswitcher {
            background-color: transparent;
            padding: 40px;
          }

          #main-view {
              background-color: var(--bg-color);
              border-radius: 22px;
              border: 1px solid var(--border-color);
              padding: 10px 20px 10px;
              box-shadow: 0 0 20px 5px rgba(0,0,0,.3),
                0 0 13px 8px rgba(0,0,0,.2);
          }

          .workspace scrollbar, .workspace scrollbar * {
            background-color: transparent;
            min-width: 0px;
            min-height: 0px;
            opacity: 0;
          }

          .workspace scrollbar,
          .workspace scrollbar slider {
              background: transparent;
              min-width: 6px;
              min-height: 6px;
          }


          #application-title {
              background: transparent;
              color: var(--label-color);
              transition: all 0.2s ease-in-out;
          }

          #workspace-name {
              transition: all 0.2s ease-in-out;
              background-color: var(--highlight-color);
              color: var(--alternate-label-color);
              border-radius: 22px;
              padding: 3px 9px;
          }


          #workspaces {
              margin: 5px 10px 5px;
          }

          .workspace-indicator {
              background-color: var(--indicator-color);
              transition: background 200ms 20ms;
              margin:0;
          }

          .workspace-indicator:first-child {
              border-radius: 20% 20% 0 0;
          }

          .workspace-indicator:last-child {
              border-radius: 0 0 20% 20%;
          }

          .workspace-indicator.selected {
              background-color: var(--indicator-focus-color);
          }

          .workspace-indicator:hover {
              background-color: var(--indicator-focus-color);
          }

          #workspace-indicators {
              background: transparent;
              margin-top: 22px;
              margin-bottom: 22px;
              margin-right: 2px;
          }


          .application {
            background-color: transparent;
          }

          .application-icon {
              transition: -gtk-icon-filter 0.2s ease-in-out;
              padding: 10px 15px 10px;
              -gtk-icon-shadow: 0 1px 1px hsl(0deg 0% 0% / 0.075),
                  0 2px 2px hsl(0deg 0% 0% / 0.075),
                  0 4px 4px hsl(0deg 0% 0% / 0.075),
                  0 8px 8px hsl(0deg 0% 0% / 0.075),
                  0 16px 16px hsl(0deg 0% 0% / 0.075);
          }

          .application-name {
            transition: opacity 0.2s ease;
            opacity: 0;
            color: var(--dim-label-color);
            margin-top: 3px;
          }

          .application.selected .application-name {
            opacity: 1;
            color: var(--label-color);
          }

          .application.urgent .application-icon {
            animation-timing-function: linear;
            animation: urgency-pulse-animation 2.5s infinite;
          }

          @keyframes urgency-pulse-animation {
           0% {
                -gtk-icon-filter: drop-shadow(0 0 2px var(--urgency-color));
            }

            25% {
              -gtk-icon-filter: drop-shadow(0 0 5px var(--urgency-color));
            }

            50% {
              -gtk-icon-filter: drop-shadow(0 0 10px var(--urgency-color));
            }

            75% {
              -gtk-icon-filter: drop-shadow(0 0 5px var(--urgency-color));
              }

            100% {
              -gtk-icon-filter: drop-shadow(0 0 2px var(--urgency-color));
            }
          }

          .application.focused .application-name {
            opacity: 1;
            color: var(--dim-label-color);
          }

          .application.selected .application-icon {
              transition: background-color 0.1s ease-in;
              border-radius: 10%;
              background-color: var(--highlight-color);
          }
        '';
    };
  };
}
