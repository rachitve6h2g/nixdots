{ self, ... }:
let
  inherit (self) theme;
in
{
  perSystem = {
    wrappers.packages.niri = true;
  };

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
              # font = "${config.stylix.fonts.monospace.name}"; # TODO: Change font here
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
    in
    {
      apply = true;
      imports = [ wlib.wrapperModules.niri ];

      settings =
        let
          noctalia = cmd: "noctalia-shell ipc call ${cmd}";
        in
        {
          binds = {
            "Mod+G".spawn-sh = noctalia "launcher clipboard"; # Clipboard
            "Mod+D".spawn-sh = noctalia "launcher toggle"; # Launcher

            "Mod+E".spawn-sh = "Thunar";

            "Mod+F".spawn-sh = pkgs.lib.getExe (mkMenu [
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

            "Mod+Return".spawn-sh = pkgs.lib.getExe (mkMenu [
              {
                key = "e";
                desc = "Emacsclient";
                # TODO: Change interpolation to take from emacs wrapper
                cmd = "${pkgs.emacs-pgtk}/bin/emacsclient -a \"emacs\" -c";
              }
              {
                key = "t";
                desc = "Terminal";
                cmd = "footclient"; # TODO: Change to foot
              }
            ]);

            "Mod+Q".close-window = null;
            "Mod+BracketLeft".consume-or-expel-window-left = null;
            "Mod+BracketRight".consume-or-expel-window-right = null;

            "Mod+Comma".consume-window-into-column = null;
            "Mod+Period".expel-window-from-column = null;

            # "Mod+R".action = set-preset-column-width;
            "Mod+Shift+R".switch-preset-window-height = null;
            "Mod+Ctrl+R".reset-window-height = null;

            # TODO: set to maximize-window-to-edges.
            # It's still not implemented in sodiboo/niri-flake.
            "Mod+M".maximize-column = null;
            "Mod+Shift+M".fullscreen-window = null;
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
            };
            XF86AudioLowerVolume = {
              spawn-sh = noctalia "volume decrease";

            };
            XF86AudioMute = {
              spawn-sh = noctalia "volume muteOutput";
            };
            XF86MonBrightnessUp = {
              spawn-sh = noctalia "brightness increase";
            };
            XF86MonBrightnessDown = {
              spawn-sh = noctalia "brightness decrease";
            };
            XF86AudioNext = {
              spawn-sh = noctalia "media next";
            };
            XF86AudioPause = {
              spawn-sh = noctalia "media playPause";
            };
            XF86AudioPlay = {
              spawn-sh = noctalia "media playPause";
            };
            XF86AudioPrev = {
              spawn-sh = noctalia "media previous";
            };

            # Move around windows in a workspace using vim keys.
            # Vim movement keys are easier, since using the mod key
            # is easier with vim keys
            "Mod+H".focus-column-left-or-last = null;
            "Mod+L".focus-column-right-or-first = null;
            "Mod+K".focus-window-or-workspace-up = null;
            "Mod+J".focus-window-or-workspace-down = null;

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
        };
    };
}
