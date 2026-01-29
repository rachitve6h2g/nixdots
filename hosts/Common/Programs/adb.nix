{ pkgs, globalValues, ... }:
{
  users.users.${globalValues.username}.extraGroups = [
    "kvm"
    "adbusers"
  ];

  #  programs.adb.enable = true;
  environment.systemPackages = [
    pkgs.scrcpy
    pkgs.android-tools
  ];
}
