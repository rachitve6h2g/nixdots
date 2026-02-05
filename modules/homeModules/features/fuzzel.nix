{
  flake.homeModules.fuzzel =
    { lib, pkgs, ... }:
    {
      home.packages = [
        # Fuzzel Powermenu Script
        (pkgs.writeShellScriptBin "fuzzel_powermenu.sh" ''
          set -euo pipefail

          choice="$(
            printf '%s\n' \
              "1. Poweroff" \
              "2. Restart" \
              "3. Lock" \
              "4. Suspend" |
              ${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt="Say bye or good night!   " --lines=4
          )"

          [[ -z "$choice" ]] && exit 0

          case "$choice" in
          "1. Poweroff") notify-send "The computer will shutdown in 3 seconds" && sleep 3 && systemctl poweroff ;;
          "2. Restart") notify-send "The computer will reboot in 3 seconds" && sleep 3 && systemctl reboot ;;
          "3. Lock") loginctl lock-session ;;
          "4. Suspend") notify-send "Going for quick nap!" && sleep 2 && systemctl suspend ;;
          esac
        '')

        # Fuzzel Browser search
        (pkgs.writeShellScriptBin "fuzzel_browser.sh" ''
          ${pkgs.fuzzel}/bin/fuzzel --dmenu --lines 0 --placeholder "Type your search" | sed 's/^/\"/g;s/$/\"/g' | xargs ${pkgs.firefox}/bin/firefox --search
        '')

        # Fuzzel Tomat Menu
        (pkgs.writeShellScriptBin "fuzzel_tomat.sh" ''
          choice="$(
            printf '%s\n' \
            "toggle" \
            "start" \
            "stop" \
            "status" \
            "skip" \
            "pause" \
            "resume" |
            ${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt="🍅  " --lines=7
          )"

          [[ -n "$choice" ]] && ${pkgs.tomat}/bin/tomat "$choice"
        '')

        # Fuzzel Supermenu
        (pkgs.writeShellScriptBin "fuzzel_supermenu.sh" ''
          set -euo pipefail

          choice="$(printf '%s\n' \
            "1. Menu" \
            "2. Emoji" \
            "3. Tomat" \
            "4. Power Menu" \
            "5. Search" \
            "6. Clipboard" |
            ${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt="Supermenu  " --lines=6
          )"

          [[ -z "$choice" ]] && exit 0

          case "$choice" in
          "1. Menu") ${pkgs.fuzzel}/bin/fuzzel ;;
          "2. Emoji") ${pkgs.bemoji}/bin/bemoji ;;
          "3. Tomat") fuzzel_tomat.sh ;;
          "4. Power Menu") fuzzel_powermenu.sh ;;
          "5. Search") fuzzel_browser.sh ;;
          "6. Clipboard") ${pkgs.cliphist}/bin/cliphist-fuzzel-img ;;
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
