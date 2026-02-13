{
  flake.homeModules.shell = {
    programs = {
      yt-dlp = {
        enable = true;
        settings = {
          downloader = "aria2c";
          downloader-args = "aria2c:'-c -j 3 -x8 -s8 -k1M'";
          format = "bestvideo+bestaudio/best";
          embed-thumbnail = true;
          embed-subs = true;
        };
      };
    };
  };
}
