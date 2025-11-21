{ inputs, pkgs, ... }:
{
  imports = [
    # ./vscodium.nix
  ];
  home.packages = [ inputs.knvim.packages.${pkgs.stdenv.system}.default ];
}
