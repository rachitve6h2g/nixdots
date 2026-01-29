{
  lib,
  ...
}:
let
  inherit (lib) mkOption types;
  in
{
  options.globalValues = {
    username = mkOption {
      type = types.str;
      description = "Define the username here";
      default = "krish";
    };

    hostname = mkOption {
      type = types.str;
      description = "Define the hostname here";
      default = "nixpavilion";
    };

    theme = mkOption {
      type = types.enum [ "nord" "gruvbox" "catppuccin" "rosepine" ];
      default = "nord";
      description = "Global theme settings";
    };
  };

  config.globalValues = {
    username = "krish";
    hostname = "nixpavilion";
    theme = "nord";
  };
}
