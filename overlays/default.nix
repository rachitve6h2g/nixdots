{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.nur.overlays.default
    inputs.niri-flake.overlays.niri
  ];
}
