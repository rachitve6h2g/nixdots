{
  flake.homeModules.shell =
    { pkgs, ... }:
    {
      programs.tealdeer = {
        enable = true;
        enableAutoUpdates = true;

        settings = {
          display = {
            compact = false;
            use_pager = true;
          };
          updates = {
            auto_update = true;
            auto_update_interval_hours = 24;
          };
        };
      };

      services.tldr-update = {
        enable = true;
        period = "weekly";
      };
    };
}
