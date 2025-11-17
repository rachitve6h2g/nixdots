{ config, ... }:
{
  programs = {
    yt-dlp = {
      enable = true;
      settings = {
        downloader = "aria2c";
        # See https://wiki.archlinux.org/title/Aria2#Changing_the_User_Agent
        # I tried changing the user agent but it still didn't work.
        downloader-args = "aria2c:'-c -j 3 -x 3 -s 3 -k 1M'";
        format = "bestvideo+bestaudio/best";
        embed-thumbnail = true;
        add-metadata = true;
      };
    };

    # Aria2 in yt-dlp manages itself.
    # If you enable this, ~/.config/aria2/config will
    # be created which interferes with other yt-dlp or something.

    aria2 = {
      enable = true;
      settings = {
        continue = true;
        dir = "${config.xdg.userDirs.download}";
        file-allocation = "none";
        max-connection-per-server = 4;
        min-split-size = "5M";
        log-level = "warn";
      };
    };
  };
}
