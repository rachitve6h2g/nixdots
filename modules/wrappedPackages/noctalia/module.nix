{ self, ... }:
{
  flake.wrappers.noctalia =
    {
      config,
      lib,
      wlib,
      pkgs,
      ...
    }:
    let
      hasOtherFiles =
        config.colors != { }
        || config.plugins != { }
        || config.user-templates != { }
        || config.pluginSettings != { };
      constructToml = constructAttrs true;
      constructJson = constructAttrs false;
      constructAttrs =
        toml: val:
        if builtins.isString val then
          {
            content = val;
          }
        else if builtins.isPath val || lib.isStorePath val then
          {
            builder = ''
              mkdir -p "$(dirname "$2")"
              cp ${val} "$2"
            '';
          }
        else
          {
            content = builtins.toJSON val;
          }
          // lib.optionalAttrs toml {
            builder = ''
              mkdir -p "$(dirname "$2")"
              ${pkgs.remarshal}/bin/json2toml "$1" "$2"
            '';
          };
    in
    {
      config.meta.description = ''
        If you only supply `settings`, and do not choose somewhere for `outOfStoreConfig` then it will only generate and set `NOCTALIA_SETTINGS_FILE`

        If you leave `outOfStoreConfig == null` as it is by default, and you supply more then just `settings`, it will set `NOCTALIA_CONFIG_DIR` to the generated location

        If you do `outOfStoreConfig = "/some/path/somewhere";` and `/some/path/somewhere` does not yet exist, it will copy it there at runtime when you start `noctalia-shell` and set `NOCTALIA_CONFIG_DIR` to that location instead.

        This wrapper module also provides an extra executable in the bin directory called `dump-noctalia-shell`

        It will return the current settings and state of noctalia in nix code format.
      '';
      imports = [ wlib.modules.default ];
      options = {
        generatedConfigDirname = lib.mkOption {
          type = lib.types.str;
          default = "${config.binName}-config";
          description = "Name of the directory which is created as the NOCTALIA_CONFIG_DIR in the wrapper output";
        };
        configDrvOutput = lib.mkOption {
          type = lib.types.str;
          default = config.outputName;
          description = "Name of the derivation output where the generated NOCTALIA_CONFIG_DIR is output to.";
        };
        outOfStoreConfig = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = ''
            If provided, and the location does not exist yet, the wrapper script will copy the generated configuration to this location, and use it for NOCTALIA_CONFIG_DIR.
          '';
        };
        settings = lib.mkOption {
          type =
            with lib.types;
            oneOf [
              json
              str
              path
            ];
          default = import ./_noctalia-settings.nix { inherit self pkgs; };
          example = lib.literalExpression ''
            {
              bar = {
                position = "bottom";
                floating = true;
                backgroundOpacity = 0.95;
              };
              general = {
                animationSpeed = 1.5;
                radiusRatio = 1.2;
              };
              colorSchemes = {
                darkMode = true;
                useWallpaperColors = true;
              };
            }
          '';
          description = ''
            Noctalia shell configuration settings as an attribute set, string
            or filepath, to be written to ~/.config/noctalia/settings.json.
          '';
        };

        colors = lib.mkOption {
          type =
            with lib.types;
            oneOf [
              json
              str
              path
            ];
          # default = { };
          default = import ./_colors.nix { inherit self; };
          example = lib.literalExpression ''
             {
               mError = "#dddddd";
               mOnError = "#111111";
               mOnPrimary = "#111111";
               mOnSecondary = "#111111";
               mOnSurface = "#828282";
               mOnSurfaceVariant = "#5d5d5d";
               mOnTertiary = "#111111";
               mOutline = "#3c3c3c";
               mPrimary = "#aaaaaa";
               mSecondary = "#a7a7a7";
               mShadow = "#000000";
               mSurface = "#111111";
               mSurfaceVariant = "#191919";
               mTertiary = "#cccccc";
            }
          '';
          description = ''
            Noctalia shell color configuration as an attribute set, string
            or filepath, to be written to ~/.config/noctalia/colors.json.
          '';
        };

        user-templates = lib.mkOption {
          default = { };
          type =
            with lib.types;
            oneOf [
              (pkgs.formats.toml { }).type
              str
              path
            ];
          example = lib.literalExpression ''
            {
              templates = {
                neovim = {
                  input_path = "~/.config/noctalia/templates/template.lua";
                  output_path = "~/.config/nvim/generated.lua";
                  post_hook = "pkill -SIGUSR1 nvim";
                };
              };
            }
          '';
          description = ''
            Template definitions for Noctalia, to be written to ~/.config/noctalia/user-templates.toml.

            This option accepts:
            - a Nix attrset (converted to TOML automatically)
            - a string containing raw TOML
            - a path to an existing TOML file
          '';
        };

        plugins = lib.mkOption {
          type =
            with lib.types;
            oneOf [
              json
              str
              path
            ];
          default = {
            sources = [
              {
                enabled = true;
                name = "Noctalia Plugins";
                url = "https://github.com/noctalia-dev/noctalia-plugins";
              }
            ];

            states = {
              pomodoro = {
                enabled = true;
                sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
              };
            };
          };
          example = lib.literalExpression ''
            {
              sources = [
                {
                  enabled = true;
                  name = "Noctalia Plugins";
                  url = "https://github.com/noctalia-dev/noctalia-plugins";
                }
              ];
              states = {
                catwalk = {
                  enabled = true;
                  sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
                };
              };
              version = 2;
            }
          '';
          description = ''
            Noctalia shell plugin configuration as an attribute set, string
            or filepath, to be written to ~/.config/noctalia/plugins.json.
          '';
        };

        pluginSettings = lib.mkOption {
          type =
            with lib.types;
            attrsOf (oneOf [
              json
              str
              path
            ]);
          default = { };
          example = lib.literalExpression ''
            {
              catwalk = {
                minimumThreshold = 25;
                hideBackground = true;
              };
            }
          '';
          description = ''
            Each plugin’s settings as an attribute set, string
            or filepath, to be written to ~/.config/noctalia/plugins/plugin-name/settings.json.
          '';
        };
      };
      config.runShell = lib.mkIf (config.outOfStoreConfig != null) [
        {
          name = "COPY_GENERATED_CONFIG";
          data = ''
            mkdir -p ${config.outOfStoreConfig}
            cp -rn "${placeholder config.configDrvOutput}/${config.generatedConfigDirname}/." ${config.outOfStoreConfig};
          '';
        }
      ];
      config.package = pkgs.noctalia-shell;
      config.env.NOCTALIA_SETTINGS_FILE = lib.mkIf (
        config.outOfStoreConfig == null && config.settings != { } && !hasOtherFiles
      ) config.constructFiles.settings.path;
      config.env.NOCTALIA_CONFIG_DIR = lib.mkIf (hasOtherFiles || config.outOfStoreConfig != null) (
        if config.outOfStoreConfig != null then
          config.outOfStoreConfig
        else
          "${placeholder config.configDrvOutput}/${config.generatedConfigDirname}/"
      );
      config.buildCommand.makeDirAnywayToSilenceWarning = ''
        mkdir -p "${placeholder config.configDrvOutput}/${config.generatedConfigDirname}/plugins"
      '';
      config.constructFiles = {
        dump-noctalia-shell = {
          key = "dumpNoctaliaShell";
          relPath = "bin/dump-noctalia-shell";
          builder = ''mkdir -p "$(dirname "$2")" && cp "$1" "$2" && chmod +x "$2"'';
          content = ''
            #!${pkgs.bash}/bin/bash
            ${config.wrapperPaths.placeholder} ipc call state all > /tmp/noctalia.json && \
            ${lib.getExe pkgs.nix} eval --impure --expr 'builtins.fromJSON (builtins.readFile /tmp/noctalia.json)'
          '';
        };
        settings = lib.mkIf (config.settings != { }) (
          {
            relPath = "${config.generatedConfigDirname}/settings.json";
            output = config.configDrvOutput;
          }
          // constructJson config.settings
        );
        colors = lib.mkIf (config.colors != { }) (
          {
            relPath = "${config.generatedConfigDirname}/colors.json";
            output = config.configDrvOutput;
          }
          // constructJson config.colors
        );
        plugins = lib.mkIf (config.plugins != { }) (
          {
            relPath = "${config.generatedConfigDirname}/plugins.json";
            output = config.configDrvOutput;
          }
          // constructJson config.plugins
        );
        user-templates = lib.mkIf (config.user-templates != { }) (
          {
            key = "userTemplates";
            relPath = "${config.generatedConfigDirname}/user-templates.toml";
            output = config.configDrvOutput;
          }
          // constructToml config.user-templates
        );
      }
      // lib.pipe config.pluginSettings [
        (lib.mapAttrsToList (
          name: value:
          lib.nameValuePair name {
            relPath = "${config.generatedConfigDirname}/plugins/${name}/settings.json";
            output = config.configDrvOutput;
          }
          // constructJson value
        ))
        (lib.imap0 (
          i: v:
          v
          // {
            value = v.value // {
              key = "plugin_${i}";
            };
          }
        ))
        builtins.listToAttrs
      ];
    };
}
