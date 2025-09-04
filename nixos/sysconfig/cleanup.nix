{ config, ... }:
{
  nix = {
    settings.auto-optimise-store = true;

    # When using programs.nh.clean.enable, don't use this.
    gc = {
      automatic = if config.programs.nh.clean.enable == true then false else true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };

    optimise = {
      automatic = true;
      dates = [ "03:45" ];
    };
  };
}
