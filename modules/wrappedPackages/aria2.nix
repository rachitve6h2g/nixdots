{
  perSystem.wrappers.packages.aria2 = true;
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

      configFile = pkgs.writeText "aria2Wrapped.conf" (
        lib.concatStringsSep "\n" (lib.mapAttrsToList formatLine config.settings) + "\n"
      );
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
          };
          description = "Settings to be wrapped with aria2 binary";
        };
      };
      config = {
        package = pkgs.aria2;
        flags = {
          "--conf-path" = configFile;
        };
      };
    };
}
