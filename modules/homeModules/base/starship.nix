{
  flake.homeModules.shell = {
    programs = {
      starship = {
        enable = true;
        enableBashIntegration = true;
      };
    };
  };
}
