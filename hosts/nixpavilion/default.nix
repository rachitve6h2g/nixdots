# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  # pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
    inputs.self.diskoConfigurations.nixpavilion # Used with flake-parts
    # ./disko-config.nix # use only when flake-parts sorta fails... ?
    ./sysconfig
  ];

  

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
}
