{
  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5 --keep-since 3d";
      };
      # Does not work with Nushell, must set the FLAKE environment yourself.
      flake = "/home/krish/.dotfiles";
    };
  };
}
