{ self, ... }:
{
  flake.wrappers.yt-dlp =
    {
      wlib,
      pkgs,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.yt-dlp ];
      settings = {
        downloader = "aria2c";
        downloader-args = "aria2c:'-c -j 3 -x8 -s8 -k1M'";
        format = "bestvideo+bestaudio/best";
        embed-thumbnail = true;
        embed-subs = true;
        embed-metadata = true;
        sub-langs = "all,-live_chat"; # Excludes live_chat from being downloaded as subtitle
      };
      extraPackages = [
        (self.packages.${pkgs.stdenv.hostPlatform.system}.aria2)
      ];

      wrapperVariants = {
        yt-dlp = {
          binName = "yt-music";
          addFlag = [
            "-x"
            [
              "--audio-format"
              "flac"
            ]
            [
              "--audio-quality"
              "0"
            ]
            [
              "--write-subs"
              "--convert-subs"
              "lrc"
            ]
            [
              "--parse-metadata"
              "playlist_index:%(track_number)s"
            ]
            [
              "-o"
              "~/Music/%(artist,uploader)s/%(album,playlist_title)s/%(track_number)02d - %(title)s.%(ext)s"
            ]
          ];
        };
      };
    };
}
