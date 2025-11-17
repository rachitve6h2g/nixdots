{
  config,
  ...
}:
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
      '';
    };

    mpd-mpris = {
      enable = true;
    };
  };
}
