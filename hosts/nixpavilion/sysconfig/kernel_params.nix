{ pkgs, ... }:
{
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "splash"
      # "zswap.enabled=0"
      "i915.force_probe=!a7a0"
      "xe.force_probe=a7a0"
    ];
  };
}
