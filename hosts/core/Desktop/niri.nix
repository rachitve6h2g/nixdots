{ inputs, pkgs, ... }:
{
  imports = [ inputs.niri-flake.nixosModules.niri ];
  programs = {
    niri = {
      enable = true;
      package = pkgs.niri;
    };

    uwsm = {
      enable = true;
      waylandCompositors = {
        niri = {
          prettyName = "Niri";
          comment = "Niri compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri -- --session";
        };
      };
    };
  };
  security.pam.services.swaylock = { };

  # To not use the niri polkit agent
  systemd.user.services.niri-flake-polkit.enable = false;
}
