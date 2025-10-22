{ pkgs, ... }:
{
  users.users.krish.extraGroups = [
    "kvm"
    "adbusers"
  ];
  programs.adb.enable = true;
  serveices.udev.packages = [ pkgs.android-udev-rules ];
}
