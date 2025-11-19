{ config, ... }:
{
  programs = {
    vivid = {
      enable = if config.programs.dircolors.enable then false else true;
      enableBashIntegration = true;
      activeTheme = "catppuccin-mocha";
      colorMode = "24-bit";
    };
  };
}
