{
  flake.wrappers.aria2 =
    {
      wlib,
      lib,
      pkgs,
      config,
      ...
    }:
    let
      formatLine =
        n: v:
        let
          formatValue = v: if builtins.isBool v then (if v then "true" else "false") else toString v;
        in
        "${n}=${formatValue v}";
    in
    {
      imports = [ wlib.modules.default ];

      options = {
        settings = lib.mkOption {
          type =
            with lib.types;
            attrsOf (oneOf [
              bool
              float
              int
              str
            ]);
          default = {
            continue = true;
            dir = "/home/krish/Downloads";
            input-file = "/home/krish/Downloads/.aria_downloads.conf";
            file-allocation = "none";
            log-level = "warn";
            max-connection-per-server = 4;
            min-split-size = "5M";
            on-download-complete = "exit";
            auto-file-renaming = false;
          };
          description = "Settings to be wrapped with aria2 binary";
        };
      };
      config = {
        package = pkgs.aria2;
        binName = "aria2c";
        flags = {
          "--conf-path" = "${placeholder "bin"}/${config.binName}-settings.conf";
        };
        flagSeparator = "=";
        drv = {
          renderedSettings = lib.concatStringsSep "\n" (lib.mapAttrsToList formatLine config.settings);
          passAsFile = [ "renderedSettings" ];

          buildPhase = ''
            runHook preBuild
            cp $renderedSettingsPath "$bin/${config.binName}-settings.conf"
            rm $bin/bin/aria2c
            cp $out/bin/aria2c $bin/bin
            runHook postBuild
          '';
        };
      };
    };

}
