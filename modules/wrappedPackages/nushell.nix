{ self, ... }:
{
  perSystem.wrappers.packages.nushell = true;

  flake.wrappers.nushell =
    {
      pkgs,
      lib,
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

      "config.nu".content = ''
        # Common ls aliases and sort them by type and then name
        # Inspired by https://github.com/nushell/nushell/issues/7190
        def lla [...args] { ls -la ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
        def la  [...args] { ls -a  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
        def ll  [...args] { ls -l  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
        def l   [...args] { ls     ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
      '';
    };
}
