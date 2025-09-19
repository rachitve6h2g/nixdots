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
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/gruvbox_tux.png";
    hash = "sha256-AqUKCbT61A5T9lzoW09GF75vNvoHJnopu/RNtQjggdU=";
  };
}
