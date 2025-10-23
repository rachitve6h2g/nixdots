{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [ inputs.niri-flake.nixosModules.niri ];

  programs = {
    dconf.enable = true;
    niri = {
      enable = true;
      package = pkgs.niri-stable;
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

  # To not use the niri polkit agent
  systemd.user.services.niri-flake-polkit.enable = false;

  security.pam.services.swaylock = { };

  # Enable the sodiboo official cache.
  niri-flake.cache.enable = true;

  # xdg desktop portal
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];
  xdg.portal = config.home-manager.users.krish.xdg.portal // {
    wlr.enable = true;
  };
}
