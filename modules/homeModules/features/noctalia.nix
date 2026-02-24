{ inputs, ... }:
{
  flake.homeModules.noctalia =
    { pkgs, ... }:
    let
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/rachitve6h2g/Wallpapers/main/Shinchan.png";
        hash = "sha256-CP9uGyslZ19wCaglMb1UG+NmcU/GxN5HDXSdrO5jAlw=";
      };
    in
    {
      imports = [ inputs.noctalia.homeModules.default ];

      home = {
        file.".face".source = image;
        packages = [
          pkgs.mission-center # For a system monitor
          pkgs.kdePackages.qttools # For kdeconnect plugin
          # Use it to just see the diff and move the differences here.
          (pkgs.writeShellScriptBin "noctalia-diff" ''
            nix shell nixpkgs#jq nixpkgs#colordiff \
            -c bash -c "colordiff -u --nobanner \
            <(jq -S . ~/.config/noctalia/settings.json) \
            <(noctalia-shell ipc call state all | jq -S .settings)"
          '')
        ];
      };

      programs.noctalia-shell = {
        enable = true;
        systemd.enable = true;

        # Plugins
        plugins = {
          sources = [
            {
              enabled = true;
              name = "Official Noctalia Plugins";
              url = "https://github.com/noctalia-dev/noctalia-plugins";
            }
          ];
          states = {
            niri-overview-launcher = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
            pomodoro = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
            kde-connect = {
              enabled = true;
              sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
            };
          };
        };

        pluginSettings = {
          pomodoro = {
            autoStartBreaks = true;
            autoStartWork = true;
            compactMode = true;
            longBreakDuration = 15;
            playSound = true;
            sessionsBeforeLongBreak = 4;
            shortBreakDuration = 5;
            workDuration = 25;
          };
        };

        # Settings
        settings = import ./_noctalia-settings.nix;
      };
    };
}
