{
  flake.homeModules.media =
    { pkgs, config, ... }:
    {
      services = {
        playerctld.enable = true; # Control mpris with media hotkeys

        mpd = {
          enable = true;
          enableSessionVariables = true;
          musicDirectory = "${config.home.homeDirectory}/Music";
          playlistDirectory = "${config.xdg.configHome}/mpd/playlists";
          dbFile = "${config.xdg.configHome}/mpd/database";

          network = {
            listenAddress = "any";
            startWhenNeeded = true;
          };

          extraConfig = ''
            auto_update "yes"
            pid_file  "~/.config/mpd/pid"
            state_file "~/.local/state/mpd/state"
            sticker_file "~/.config/mpd/sticker.sql"

            audio_output {
              type "pipewire"
              name "PipeWire Sound Server"
            }
          '';
        };
        mpd-mpris = {
          enable = true;
        };

      };

      programs = {
        rmpc.enable = true;
        # MPV
        mpv.enable = true;

        # Cava audio visualizer
        cava = {
          enable = true;
          package = pkgs.cava;
          settings = {
            general = {
              framerate = 60;
              autosens = 1;
              sensitivity = 100;
              lower_cutoff_freq = 50;
              higher_cutoff_freq = 10000;
              # bar_width = 0.5;
            };
            output = {
              method = "ncurses";
            };
            smoothing = {
              monstercat = 1;
              waves = 1;
              noise_reduction = 88;
            };
          };
        };
      };
      stylix.targets.cava.rainbow.enable = true;
    };

}
