{
  flake.homeModules.hyprsunset = {
    services = {
      hyprsunset = {
        enable = true;

        settings = {
          max-gamma = 150;

          profile = [
            {
              time = "7:30";
              identity = true;
            }

            {
              time = "16:00";
              temperature = 5000;
            }

            {
              time = "21:00";
              temperature = 4500;
              gamma = 0.8;
            }
          ];
        };
      };
    };
  };
}
