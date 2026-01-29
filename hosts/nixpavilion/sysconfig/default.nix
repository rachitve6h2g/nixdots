{ pkgs, ... }:
{
  imports = [
    ./battery.nix
    ./btrfs-autoscrub.nix
    ./clamav.nix
    ./compileopts.nix
    # ./fingerprint.nix
    ./graphics.nix
    ./kernel_params.nix
    ./networking.nix
    ./tmp_on_ram.nix
    # ./zram.nix
    ./zswap.nix
  ];

}
