{ pkgs, ... }:
let
  updateSystem = pkgs.writeShellScriptBin "update_system" ''
    set -euo pipefail
    nix flake update --flake $HOME/.knvim
    nh os switch --update
  '';
  cleanSystem = pkgs.writeShellScriptBin "clean_system" ''
    set -euo pipefail
    nh clean all
  '';
in
{
  home.packages = [
    updateSystem
    cleanSystem
  ];
}
