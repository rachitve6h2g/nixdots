{
  flake.homeModules.fuzzel =
    { lib, pkgs, ... }:
    {
      home.packages = [
        (pkgs.writeShellScriptBin "fuzzel-powermenu" ''
          set -euo pipefail

          choice="$(
            printf '%s\n' \
              "Poweroff" \
              "Restart" \
              "Lock" \
              "Suspend" |
              fuzzel --dmenu
          )"

          [[ -z "$choice" ]] && exit 0

          case "$choice" in
          "Poweroff") notify-send "The computer will shutdown in 60 seconds" && sleep 60 && systemctl poweroff ;;
          "Restart") notify-send "The computer will reboot in 10 seconds" && sleep 10 && systemctl reboot ;;
          "Lock") loginctl lock-session ;;
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
