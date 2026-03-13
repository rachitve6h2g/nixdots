{
  flake.wrappers.bottom =
    {
      wlib,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.bottom ];
      settings = {
        flags = {
          avg_cpu = true;
          temperature_type = "c";
        };
        colors = {
          low_battery_color = "red";
        };
        styles.theme = "gruvbox";
      };
    };
}
