{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.thunard;
in
{
  options.services.thunard = {
    enable = lib.mkEnableOption "Enable the thunar daemon";
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.thunard = {
      Unit = {
        After = [ "niri.service" ];
        Requires = [ "niri.service" ];
        PartOf = [ "graphical-session.target" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.xfce.thunar}/bin/thunar --daemon";
      };
    };
  };
}
