{
  flake.homeModules.fuzzel =
    { lib, pkgs, ... }:
    {
      home.packages = [
        (pkgs.writeShellScriptBin "fuzzel-powermenu" ''
          set -euo pipefail

          choice="$(
            printf '%s\n' \
              "1. Poweroff" \
              "2. Restart" \
              "3. Lock" \
              "4. Suspend" |
              fuzzel --dmenu --prompt="Say bye or good night!   " --lines=4
          )"

          [[ -z "$choice" ]] && exit 0

          case "$choice" in
          "1. Poweroff") notify-send "The computer will shutdown in 3 seconds" && sleep 3 && systemctl poweroff ;;
          "2. Restart") notify-send "The computer will reboot in 3 seconds" && sleep 3 && systemctl reboot ;;
          "3. Lock") loginctl lock-session ;;
          "4. Suspend") notify-send "Going for quick nap!" && sleep 2 && systemctl suspend ;;
          esac
        '')
      ];

      programs.fuzzel = {
        enable = true;

        settings = lib.mkAfter {
          main = {
            terminal = "${pkgs.kitty}/bin/kitty";
          };
        };
      };
    };
}
