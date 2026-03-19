{
  self,
  # inputs,
  ...
}:
{
  flake.wrappers.noctalia-mine =
    { pkgs, ... }:
    {
      imports = [ self.wrapperModules.noctalia ];
      # outOfStoreConfig = "/home/krish/noctalia-conf";
      colors = import ./_colors.nix { inherit self; };
      settings = import ./_noctalia-settings.nix { inherit self pkgs; };
      # plugins = import ./_noctalia-plugins.nix;
      # preInstalledPlugins = import ./_noctalia-plugins_2.nix { inherit inputs; };
    };
}
