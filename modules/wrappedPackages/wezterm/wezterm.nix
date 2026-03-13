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
      base16Yaml = (pkgs.formats.yaml { }).generate "weztermBase16.yaml" (
        { scheme = "My Generated Theme"; } // theme
      );
      wezThemesDir = (
        pkgs.runCommand "wezterm-themes-dir" { } ''
          mkdir -p $out
          cp ${base16Yaml} "$out/base16Wez.yaml"
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
