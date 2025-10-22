{ pkgs, ... }:
{
  users.users.krish.extraGroups = [
    "kvm"
    "adbusers"
  ];
  programs.adb.enable = true;
  services.udev.packages = [ pkgs.android-udev-rules ];
}
