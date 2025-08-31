{
  lib,
  ...
}:
{
  programs.dconf.enable = true;

  # Refer https://nixos.org/manual/nixos/stable/options.html programs.uwsm.enable note
  services.dbus = {
    enable = true;
    implementation = lib.mkForce "broker";
  };

  imports = [
    ./displaymanager.nix
    ./niri.nix
    ./xdgsettings.nix
  ];
}
