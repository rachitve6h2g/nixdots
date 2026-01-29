{
  flake.homeModules.wbg =
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
    };
}
