{
  self,
  lib,
  ...
}:
let
  inherit (self) theme;
  mkWhichKey =
    pkgs: menu:
    (self.wrappers.wlr-which-key.apply {
      inherit pkgs;
      settings = {
        inherit menu;
        font = "Iosevka Nerd Font 12";
        background = theme.base00;
        color = theme.base06;
        border = theme.base0F;

        separator = " ➜ ";
        border_width = 2;
        corner_r = 15;
        padding = 15;
        rows_per_column = 5;
        column_padding = 25;

        anchor = "bottom-right";
        margin_right = 0;
        margin_bottom = 5;
        margin_left = 5;
        margin_top = 0;
      };
    }).wrapper;
in
{
  flake.mkWhichKeyExe = pkgs: menu: lib.getExe (mkWhichKey pkgs menu);

  flake.wrappers.wlr-which-key =
    {
      config,
      lib,
      wlib,
      ...
    }:
    {
      imports = [ wlib.modules.default ];
      options = {
        settings = lib.mkOption {
          type = lib.types.json;
          default = { };
        };
      };
      config = {
        package = config.pkgs.wlr-which-key;
        constructFiles.config_yaml = {
          relPath = "which-config.yaml";
          content = builtins.toJSON config.settings;
          builder = ''
            mkdir -p "$(dirname "$2")"
            ${config.pkgs.remarshal}/bin/json2yaml "$1" "$2"
          '';
        };
        addFlag = [
          "${placeholder config.outputName}/which-config.yaml"
        ];
      };
    };
}
