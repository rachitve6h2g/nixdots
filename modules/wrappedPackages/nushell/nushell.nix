{ self, ... }:
{
  flake.wrappers.nushell =
    {
      pkgs,
      wlib,
      ...
    }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      extraPackages = [
        selfpkgs.btop
        selfpkgs.cava
        selfpkgs.git
      ];

      imports = [ wlib.wrapperModules.nushell ];
      filesToPatch = [
        "bin/nu"
      ];
      "config.nu".path = ./config.nu;
    };
}
