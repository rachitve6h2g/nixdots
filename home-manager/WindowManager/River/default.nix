{ pkgs, lib, ... }:
{
  wayland.windowManager.river = {
    enable = true;
    systemd.enable = true;

    extraConfig = /* bash */ '''';

    settings = {
      map =
        let
          mod = "Mod4";
          leaveSh = pkgs.writeShellScript "leave.sh" ''${builtins.readFile ./leave.sh}'';
        in
        {
          normal = {
            # Spawn kitty terminal
            "${mod} Return" = "spawn kitty";

            # Close the focused view
            "${mod} Q" = "close";

            # Launcher
            "${mod} D" = "wofi --show drun";

            # Exit river
            "${mod}+Shift E" = "spawn \"bash ${leaveSh}\"";

            # Mod+{J,K} to focus to next/previous view in the layout stack
            "${mod} J" = "focus-view next";
            "${mod} K" = "focus-view previous";

            # Mod+Shift+{J,K} to swap the focused view with the next/previous
            # view in the layout stack
            "${mod}+Shift J" = "swap next";
            "${mod}+Shift K" = "swap previous";

            # Mod+{Period,Comma} to focus the next/previous output
            "${mod} Period" = "focus-output next";
            "${mod} Comma" = "focus-output previous";

            # Mod+Shift+{Period,Comma} to send the focused view to the
            # next/previous output.
            "${mod}+Shift Period" = "send-to-output next";
            "${mod}+Shift Comma" = "send-to-output previous";

            # Mod+H and Mod+L to decrease/increase the main ratio of rivertile(1)
            "${mod} H" = "send-layout-cmd rivertile \"main-ratio -0.05\"";
            "${mod} L" = "send-layout-cmd rivertile \"main-ratio +0.05\"";

            # Mod+Shift+H and Mod+Shift+L to increment/decrement the main count of rivertile(1)
            "${mod}+Shift H" = "send-layout-cmd rivertile \"main-count +1\"";
            "${mod}+Shift L" = "send-layout-cmd rivertile \"main-count -1\"";

            # Mod+Alt+{H,J,K,L} to move views
            "${mod}+Mod1 H" = "move left 100";
            "${mod}+Mod1 J" = "move down 100";
            "${mod}+Mod1 K" = "move up 100";
            "${mod}+Mod1 L" = "move right 100";

            # Mod+Alt+Control+{H,J,K,L} to snap views to screen edges
            "${mod}+Mod1+Control H" = "snap left";
            "${mod}+Mod1+Control J" = "snap down";
            "${mod}+Mod1+Control K" = "snap up";
            "${mod}+Mod1+Control L" = "snap right";

            # Mod+Alt+Shif+{H,J,K,L} to resize views
            "${mod}+Mod1+Shift H" = "resize horizontal -100";
            "${mod}+Mod1+Shift J" = "resize vertical 100";
            "${mod}+Mod1+Shift K" = "resize vertical -100";
            "${mod}+Mod1+Shift L" = "resize horizontal 100";

            # Mod + Left Mouse Button to move views
            "${mod} BTN_LEFT" = "move-view";

            # Mod + Right Mouse Button to resize views
            "${mod} BTN_RIGHT" = "resize-view";

            # Mod+Space to toggle float
            "${mod} Space" = "toggle-float";

            # Mod+F to toggle fullscreen
            "${mod} F" = "toggle-fullscreen";

            # Mod+{Up,Right,Down,Left} to change layout orientation
            "${mod} Up" = "send-layout-cmd rivertile \"main-location top\"";
            "${mod} Right" = "send-layout-cmd rivertile \"main-location right\"";
            "${mod} Down" = "send-layout-cmd rivertile \"main-location bottom\"";
            "${mod} Left" = "send-layout-cmd rivertile \"main-location left\"";

            # Mod+F11 to enter passthru mode
            "${mod} F11" = "enter-mode passthru";
          };

          passthru = {
            "${mod} F11" = "enter-mode normal";
          };
        };

      # Declare a passthru mode. This mode has only a single mapping to return to
      # normal mode. This makes it useful for testing a nested wayland compositor
      declare-mode = [
        "locked"
        "normal"
        "passthru"
      ];
    };
  };
}
