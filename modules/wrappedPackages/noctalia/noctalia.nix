{ self, inputs, ... }:
{
  flake.wrappers.noctalia-shell =
    {
      wlib,
      pkgs,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.noctalia-shell ];
      settings = import ./_noctalia-settings.nix { inherit self pkgs; };
      # plugins = import ./_noctalia-plugins.nix;
      preInstalledPlugins = {
        pomodoro = {
          enabled = true;
          src = "${inputs.noctalia-plugins.outPath}/pomodoro";
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      colors = import ./_colors.nix { inherit self; };
    };
}
