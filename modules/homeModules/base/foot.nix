{
  flake.homeModules.shell = {
    programs.foot = {
      enable = true;
      server.enable = true;

      settings = {
        mouse.hide-when-typing = true;
      };
    };
  };
}
