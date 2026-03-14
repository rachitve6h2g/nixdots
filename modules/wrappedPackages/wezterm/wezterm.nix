{ self, ... }:
let
  inherit (self) theme;
in
{
  flake.wrappers.wezterm =
    {
      wlib,
      pkgs,
      config,
      ...
    }:
    let
      base16Toml = with theme; {
        colors = {
          cursor_fg = base00;
          foreground = base05;
          indexed = {
            "18" = base01;
            "19" = base02;
            "20" = base04;
            "21" = base06;
            "16" = base09;
            "17" = base0F;
          };
          background = base00;
          cursor_border = base05;
          selection_bg = base05;
          selection_fg = base00;
          ansi = [
            base00
            base08
            base0B
            base0A
            base0D
            base0E
            base0C
            base05
          ];
          brights = [
            base03
            base08
            base0B
            base0A
            base0D
            base0E
            base0C
            base07
          ];
          cursor_bg = base05;
        };
      };
      base16TomlTheme = (pkgs.formats.toml { }).generate "base16Wez.toml" base16Toml;
      wezThemesDir = (
        pkgs.runCommand "wezterm-themes-dir" { } ''
          mkdir -p $out
          cp ${base16TomlTheme} "$out/base16Wez.toml"
        ''
      );
    in
    {
      imports = [ wlib.wrapperModules.wezterm ];
      "wezterm.lua".content = /* lua */ ''
        local cfgdir = require("nix-info").config_dir
        require("nix-info").config_dir = nil
        package.path = package.path .. ";" .. cfgdir .. "/?.lua;" .. cfgdir .. "/?/init.lua"
        package.cpath = package.cpath .. ";" .. cfgdir .. "/?.so"
        local wezterm = require("wezterm")
        wezterm.config_dir = cfgdir
        return require("init")
      '';
      luaInfo = {
        config_dir = ./.;
        color_scheme_dirs = [
          "${config.luaInfo.config_dir}/colors"
          "${wezThemesDir}"
        ];
      };
      binName = "wezterm-gui";
    };
}
