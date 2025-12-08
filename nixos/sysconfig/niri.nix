{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri-flake.nixosModules.niri
    ./greeter.nix
  ];
  programs = {
    dconf.enable = true;
    niri = {
      enable = true;
      package = pkgs.niri;
    };
  };

  # To not use the niri polkit agent
  systemd.user.services.niri-flake-polkit.enable = true;

  security.pam.services.swaylock = { };

  # Enable the sodiboo official cache.
  niri-flake.cache.enable = false;

  # Gets enbaled by the niri-flake
  services.gnome.gnome-keyring.enable = true;
}
