{
  flake.homeModules.wlsunset = {
    services.wlsunset = {
      enable = true;
      temperature = {
        day = 5000;
        night = 3500;
      };
      sunset = "18:00";
      sunrise = "06:30";
    };
  };
}
