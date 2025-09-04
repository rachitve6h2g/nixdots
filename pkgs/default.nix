{ ... }:

let
  overlay = self: super: {
    bibata-hyprcursor = super.callPackage ./bibata-hyprcursor.nix { };
  };
in
{
  nixpkgs.overlays = [ overlay ];
}
