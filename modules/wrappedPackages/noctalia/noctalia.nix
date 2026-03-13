{ self, ... }:
{
  perSystem =
    { pkgs, lib, ... }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};

      # Whatever dump-noctalia-shell gives, only the settings of the settings block (and not the state block)
      # should enter the _noctalia-settings.nix file
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
      config,
      pkgs,
      ...
    }:
    let
      jsonFmt = pkgs.formats.json { };
      conf = jsonFmt.generate "noctalia-config" config.settings;
      plugins = jsonFmt.generate "noctalia-plugins" config.plugins;
      colors = jsonFmt.generate "noctalia-colors" config.colors;
    in
    {
      imports = [ wlib.modules.default ];
      options = {
        settings = lib.mkOption {
          inherit (jsonFmt) type;
          default = import ./_noctalia-settings.nix { inherit self pkgs; };
        };
        plugins = lib.mkOption {
          inherit (jsonFmt) type;
          default = import ./_noctalia-plugins.nix;
        };
        colors = lib.mkOption {
          inherit (jsonFmt) type;
          default = import ./_colors.nix { inherit self; };
        };
      };
      config = {
        package = pkgs.noctalia-shell;
        env = {
          XDG_CONFIG_HOME = toString (
            pkgs.linkFarm "noctalia-merged-config" (
              map
                (a: {
                  inherit (a) path;
                  name = "noctalia/" + a.name;
                })
                (
                  let
                    entry = name: path: { inherit name path; };
                  in
                  [
                    (entry "settings.json" conf)
                    (entry "plugins.json" plugins)
                    (entry "colors.json" colors)
                  ]
                )
            )
          );
        };
      };
    };
}
