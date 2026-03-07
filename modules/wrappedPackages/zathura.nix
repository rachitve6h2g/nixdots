{ self, ... }:
{
  flake.wrappers.zathura =
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
          formatValue = v: if lib.isBool v then (if v then "true" else "false") else toString v;
        in
        ''set ${n}	"${formatValue v}"'';

      formatMapLine = n: v: "map ${n}   ${toString v}";
    in
    {
      imports = [ wlib.modules.default ];
      options = {
        options = lib.mkOption {
          type =
            with lib.types;
            attrsOf (oneOf [
              bool
              str
              int
              float
            ]);
          default =
            let
              highlightTransparency = 0.5;
              getColorCh = colorName: channel: (self.themeNoHash)."${colorName}-rgb-${channel}";
              rgb = color: "rgb(${getColorCh color "r"}, ${getColorCh color "g"}, ${getColorCh color "b"})";
              rgba =
                color: alpha:
                "rgba(${getColorCh color "r"}, ${getColorCh color "g"}, ${getColorCh color "b"}, ${toString alpha})";
            in
            {
              default-bg = rgba "base00" 0.8;
              default-fg = rgb "base01";
              statusbar-fg = rgb "base04";
              statusbar-bg = rgb "base02";
              inputbar-bg = rgb "base00";
              inputbar-fg = rgb "base07";
              notification-bg = rgb "base00";
              notification-fg = rgb "base07";
              notification-error-bg = rgb "base00";
              notification-error-fg = rgb "base08";
              notification-warning-bg = rgb "base00";
              notification-warning-fg = rgb "base08";
              highlight-color = rgba "base0A" highlightTransparency;
              highlight-active-color = rgba "base0D" highlightTransparency;
              completion-bg = rgb "base01";
              completion-fg = rgb "base0D";
              completion-highlight-fg = rgb "base07";
              completion-highlight-bg = rgb "base0D";
              recolor-lightcolor = rgb "base00";
              recolor-darkcolor = rgb "base06";
            };
        };
        mappings = lib.mkOption {
          type = with lib.types; attrsOf str;
          default = { };
        };
      };
      config = {
        package = pkgs.zathura;
        flags = {
          "--config-dir" = "${placeholder "out"}/config";
        };
        flagSeparator = "=";
        drv = {
          renderedRc = lib.concatStringsSep "\n" (
            [ ]
            ++ lib.mapAttrsToList formatLine config.options
            ++ lib.mapAttrsToList formatMapLine config.mappings
          );
          passAsFile = [ "renderedRc" ];
          buildPhase = ''
            runHook preBuild
            mkdir -p "$out/config"
            cp "$renderedRcPath" "$out/config/${config.binName}rc"
            runHook postBuild
          '';
        };
      };
    };
}
