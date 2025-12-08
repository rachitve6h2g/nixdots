{ pkgs, ... }:
{
  users.users.krish.extraGroups = [
    "kvm"
    "adbusers"
  ];
  programs.adb.enable = true;
  environment.systemPackages = [ pkgs.scrcpy ];
}
