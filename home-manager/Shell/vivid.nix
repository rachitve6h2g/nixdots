{ config, ... }:
{
  programs = {
    vivid = {
      enable = if config.programs.dircolors.enable then false else true;
      enableBashIntegration = true;
      activeTheme = "gruvbox-dark-hard";
      colorMode = "24-bit";
    };
  };
}
