{
  flake.wrappers.kew =
    {
      pkgs,
      config,
      lib,
      wlib,
      ...
    }:
    let
      baseConfig = lib.generators.toINI { } config.settings;
      bindLines = lib.mapAttrsToList (key: action: "bind = ${key}, ${action}") config.keyBindings;
      kewrc = ''
        ${baseConfig}

        [key bindings]
        ${lib.concatStringsSep "\n" bindLines} 
      '';
      themeFiles = lib.mapAttrsToList (name: path: {
        name = "kew/themes/${name}.theme";
        inherit path;
      }) config.themes;
    in
    {
      imports = [ wlib.modules.default ];
      options = {
        settings = lib.mkOption {
          type = lib.types.attrs;
          default = {
            miscellaneous = {
              path = "~/Music";
              allowNotifications = false;
              hideLogo = false;
              hideHelp = false;
              hideSideCover = false;
            };
            colors = {
              theme = "gruvbox";
            };
          };
        };
        keyBindings = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          default = { };
        };

        themes = lib.mkOption {
          type = lib.types.attrsOf lib.types.path;
          default = {
            gruvbox = ./gruvbox.theme;
          };
        };
      };
      config = {
        package = pkgs.kew;
        env.XDG_CONFIG_HOME = toString (
          pkgs.linkFarm "kewrc-merged-config" (
            [
              {
                name = "kew/kewrc";
                path = pkgs.writeText "kewrc" kewrc;
              }
            ]
            ++ themeFiles
          )
        );
      };
    };
}
