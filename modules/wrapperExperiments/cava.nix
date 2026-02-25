{ self, ... }:
let
  inherit (self) theme;
in
{
  perSystem = {
    wrappers.packages.cava = true;
  };
  flake.wrappers.cava =
    {
      wlib,
      lib,
      pkgs,
      config,
      ...
    }:
    let
      iniFmt = pkgs.formats.ini { };
      configFile = iniFmt.generate "cava-config" config.settings;
    in
    {
      imports = [ wlib.modules.default ];
      options = {
        settings = lib.mkOption {
          type = iniFmt.type;
          default = {
            general = {
              framerate = 30;
              autosens = 1;
              sensitivity = 100;
              lower_cutoff_freq = 50;
              higher_cutoff_freq = 10000;
              waveform = 1;
              # bar_width = 0.5;
            };
            output = {
              method = "noncurses";
            };
            smoothing = {
              monstercat = 1;
              waves = 1;
              noise_reduction = 88;
            };
            color =
              let
                mkGradient =
                  prefix: colors:
                  builtins.listToAttrs (
                    lib.imap0 (i: c: lib.nameValuePair "${prefix}_color_${toString (i + 1)}" "'${c}'") colors
                  )
                  // {
                    "${prefix}" = 1;
                    "${prefix}_count" = builtins.length colors;
                  };
              in
              mkGradient "gradient" (
                with theme;
                [
                  base0E
                  base0D
                  base0C
                  base0B
                  base0A
                  base09
                  base08
                ]
              )
              // mkGradient "horizontal" (
                with theme;
                [
                  base0E
                  base0D
                  base0C
                  base0B
                  base0A
                  base09
                  base08
                ]
              )
              // {
                blend_direction = "up";
              };
          };
          description = "Settings to Be Written in Cava configuration file";
        };
      };
      config = {
        package = pkgs.cava;
        flags = {
          "-p" = configFile;
        };
      };
    };
}
