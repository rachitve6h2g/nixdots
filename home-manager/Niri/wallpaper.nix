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
    url = "https://github.com/rachitve6h2g/Wallpapers/blob/main/117497448_p0.jpg?raw=true";
    hash = "sha256-3r+INWEskjl+zRJga535QRWF2bS8WUyZfMw17KrKWz8=";
  };
}
