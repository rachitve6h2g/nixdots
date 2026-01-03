{
  config,
  ...
}:
let
  mpdHost = "$XDG_RUNTIME_DIR/mpd/socket";
in
{
  services = {
    mpd = {
      enable = true;
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

        bind_to_address ${mpdHost}
      '';
    };
    mpd-mpris = {
      enable = true;
    };
  };

  # For listening to Unix domain socket
  home.sessionVariables.MPD_HOST = mpdHost;
}
