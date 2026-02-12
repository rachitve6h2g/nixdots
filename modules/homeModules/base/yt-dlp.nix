{
  flake.homeModules.shell =
    { config, ... }:
    {
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

        aria2 = {
          enable = true;
          settings = {
            continue = true;
            dir = "${config.xdg.userDirs.download}";
            file-allocation = "trunc";
            log-level = "warn";
            max-connection-per-server = 4;
            min-split-size = "5M";

            # For aria2 frontend
            enable-rpc = true;
            rpc-listen-all = false;
            rpc-allow-origin-all = true;
            rpc-listen-port = 6800;
            auto-file-renaming = false; # Better resume and reusability
            split = 4; # Better parallelism
            daemon = true;
          };
        };
      };
    };
}
