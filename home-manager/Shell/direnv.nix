{
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      mise.enable = false; # If nix, why mise?
      nix-direnv.enable = true;
    };
  };
}
