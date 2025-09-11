{
  pkgs,
  ...
}:
{
  programs = {
    dconf.enable = true;

    hyprland = {
      enable = true;
      withUWSM = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };

    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
    };
  };

  security.pam.services = {
    hyprlock = { };
  };
}
