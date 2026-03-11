{ self, ... }:
{
  perSystem =
    { pkgs, lib, ... }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
      dump-noctalia-shell = pkgs.writeShellApplication {
        name = "dump-noctalia-shell";
        text = ''
          ${lib.getExe selfpkgs.noctalia-shell} ipc call state all \
          | nix eval --impure --expr 'builtins.fromJSON (builtins.readFile /dev/stdin)'
        '';
      };
    in
    {
      packages = {
        noctalia-bundle = pkgs.symlinkJoin {
          name = "noctalia-bundle";
          paths = [
            dump-noctalia-shell
            selfpkgs.noctalia-shell
          ];
        };
      };
    };
  flake.wrappers.noctalia-shell =
    {
      wlib,
      lib,
      pkgs,
      config,
      ...
    }:
    let
      jsonFormat = pkgs.formats.json { };
    in
    {
      imports = [ wlib.modules.default ];
      options = {
        settings = lib.mkOption {
          # NOTE: Just taking jsonFormat
          type = with lib.types; oneOf [ jsonFormat.type ];
          default = import ./_noctalia-settings.nix;
          description = /* text */ ''
                Noctalia Shell configuration to be wrapped to with noctalia.
            	Could be a path, a Json string or 
          '';
        };

        # TODO: package plugins and colors along
        # See https://github.com/noctalia-dev/noctalia-shell/blob/main/nix/home-module.nix
        # plugins = lib.mkOption { };
        # colors = lib.mkOption { };
      };

      config = {
        package = pkgs.noctalia-shell;
        env = {
          "NOCTALIA_SETTINGS_FILE" = jsonFormat.generate "config.json" config.settings;
        };
      };
    };
}
