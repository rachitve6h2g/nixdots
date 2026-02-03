{
  flake.homeModules.tomat = {
    services.tomat = {
      enable = true;
      settings = {
        notification = {
          enabled = true;
        };

        sound = {
          enabled = true;
        };

        timer = {
          auto_advance = false;
          break = 5;
          work = 25;
        };
      };
    };
  };
}
