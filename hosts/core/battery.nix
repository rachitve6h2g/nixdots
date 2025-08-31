{
  services = {
    upower = {
      enable = true;

      usePercentageForPolicy = true;
      percentageLow = 40;
      percentageCritical = 30;
      percentageAction = 20;

      criticalPowerAction = "PowerOff";
    };

    thermald.enable = true;

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "powersave";
          turbo = "auto";
        };
      };
    };
  };
}
