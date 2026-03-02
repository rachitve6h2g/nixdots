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
      };
      extraPackages = [
        (self.packages.${pkgs.stdenv.hostPlatform.system}.aria2)
      ];
    };
}
