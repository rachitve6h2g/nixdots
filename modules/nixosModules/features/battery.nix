{
  flake.nixosModules.battery = {
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
            energy_perf_bias = "balance_power";
            enable_thresholds = true;
            start_threshold = 20;
            stop_threshold = 80;
          };
          charger = {
            governor = "performance";
            turbo = "always";
            energy_perf_bias = "performance";
          };
        };
      };
    };
  };
}
