{
  perSystem =
    { pkgs, ... }:
    {
      packages = {
        bibata-hyprcursor = pkgs.callPackage ./bibata-hyprcursor.nix { };
      };
    };
}
