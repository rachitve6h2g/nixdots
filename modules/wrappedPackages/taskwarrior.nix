{
  flake.wrappers.taskwarrior =
    {
      wlib,
      config,
      pkgs,
      lib,
      ...
    }:
    let
      inherit (lib) types mkOption;
      formatValue =
        value:
        if lib.isBool value then
          if value then "true" else "false"
        else if lib.isList value then
          lib.concatMapStringsSep "," formatValue value
        else
          toString value;

      formatLine = key: value: "${key}=${formatValue value}";

      formatSet =
        key: values:
        (lib.concatStringsSep "\n" (
          lib.mapAttrsToList (subKey: subValue: formatPair "${key}.${subKey}" subValue) values # Values is an attrset here, not a list, because formatPair is being applied first
        ));
      formatPair = key: value: if lib.isAttrs value then formatSet key value else formatLine key value;

      configFile = lib.concatStringsSep "\n" (lib.mapAttrsToList formatPair config.taskrc);
    in
    {
      imports = [ wlib.modules.default ];
      options = {
        taskrc = mkOption {
          type = types.attrsOf types.anything;
          default = {
            news.version = "3.4.2";
            data.location = "~/.local/share/task";
            hooks.location = "~/.config/task/hooks";
          };
        };
      };
      config = {
        package = pkgs.taskwarrior3;
        env.TASKRC = pkgs.writeText "taskrc" configFile;
      };
    };
}
