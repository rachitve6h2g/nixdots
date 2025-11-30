{
  pkgs,
  config,
  ...
}:
{
  systemd.user.services.wbg = {
    Unit = {
      After = [ "niri.service" ];
      Requires = [ "niri.service" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      #TODO: make a option for wallpaper.
      ExecStart = "${pkgs.wbg}/bin/wbg ${config.stylix.image}";
    };
  };

  stylix.image = pkgs.fetchurl {
    # url = "https://4kwallpapers.com/images/wallpapers/hollow-knight-video-5120x2880-19930.jpg";
    # To get the hash run:
    # $nix hash convert --hash-algo sha256 $(nix-prefetch-url
    # <url_to_wallpaper_here)
    # hash = "sha256-mQN9d7CCNZyKI0uUA+04DvAGwotILw5TD3SfwJ7i8wQ=";
    #
    url = "https://github.com/rachitve6h2g/Wallpapers/blob/main/1347701.png?raw=true";
    hash = "sha256-bcirr2E5RFdX22ww1TF+icDN+hbeDXZwToXhNfsqzOA=";
  };
}
