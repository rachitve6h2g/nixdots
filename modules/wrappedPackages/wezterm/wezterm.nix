{
  flake.wrappers.wezterm =
    {
      wlib,
      ...
    }:
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
      };
      binName = "wezterm-gui";
    };
}
