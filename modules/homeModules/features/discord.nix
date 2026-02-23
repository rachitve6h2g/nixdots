{
  flake.homeModules.discord = {
    programs.vesktop = {
      enable = true;

      vencord.settings = {
        autoUpdate = true;
        autoUpdateNotification = true;
        useQuickCss = true;
        transparent = true;
      };
    };
  };
}
