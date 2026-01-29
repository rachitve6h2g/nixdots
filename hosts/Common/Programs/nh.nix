{
  programs = {
    nh = rec {
      enable = true;
      clean = {
        enable = true;
        dates = "daily";
        extraArgs = "--keep 5 --keep-since 3d";
      };
      flake = "/etc/nixos";
    };
  };
}
