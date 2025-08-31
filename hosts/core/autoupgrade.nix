{ inputs, ... }:
{
  system = {
    autoUpgrade = {
      enable = true;
      dates = "weekly";
      fixedRandomDelay = true;
      randomizedDelaySec = "45min";
      flake = inputs.self.outPath;
      flags = [ "-L" ];
    };
  };
}
