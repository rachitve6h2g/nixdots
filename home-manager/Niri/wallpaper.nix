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
    url = "https://raw.githubusercontent.com/ChapST1/gruvbox-wallpapers-web/master/wallpapers/mix/19.jpg";
    hash = "sha256-ZQsr2w8vzwPrWvaU7sAE69d8ouetpwe8nkBKeIGx58U=";
  };
}
