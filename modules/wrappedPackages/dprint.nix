{
  flake.wrappers.dprint =
    {
      wlib,
      pkgs,
      config,
      lib,
      ...
    }:
    {
      imports = [ wlib.modules.default ];
      options = {
        settings = lib.mkOption {
          type = lib.types.json;
          default = {
            markdown = {
              lineWidth = 120;
            };
            excludes = [ ];
            # NOTE: Remember to update plugins on your own, or better still package them using nix
            plugins = [
              "https://plugins.dprint.dev/markdown-0.21.1.wasm"
              "https://plugins.dprint.dev/toml-0.7.0.wasm"
              "https://plugins.dprint.dev/g-plane/pretty_yaml-v0.6.0.wasm"
            ];
          };
        };
      };
      config = {
        package = pkgs.dprint;
        flags = {
          "--config" = "${placeholder "out"}/${config.binName}-config/dprint.json";
        };
        env = {
          DPRINT_MAX_THREADS = "4";
          DPRINT_EDITOR = "hx";
          DPRINT_CONFIG_DIR = "${placeholder "out"}/${config.binName}-config/";
        };
        binName = "dprint";
        drv = {
          dprintConfig = (pkgs.formats.json { }).generate "dprint.json" config.settings;
          passAsFile = [ "dprintConfig" ];
          buildPhase = ''
            runHook preBuild
            mkdir -p "$out/${config.binName}-config"
            cp "$(cat "$dprintConfigPath")" "$out/${config.binName}-config/dprint.json"
            runHook postBuild
          '';
        };
      };
    };
}
