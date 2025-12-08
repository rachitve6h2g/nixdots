{ inputs, pkgs, ... }:
{
  imports = [
    # ./vscodium.nix
    ./emacs.nix
  ];
  home.packages = [ inputs.knvim.packages.${pkgs.stdenv.system}.default ];
}
