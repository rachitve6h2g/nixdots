{
  flake.homeModules.media =
    { pkgs, ... }:
    {
      services = {
        playerctld.enable = true; # Control mpris with media hotkeys
      };

      programs = {
        cmus.enable = true;

        # MPV
        mpv.enable = true;

        # Cava audio visualizer
        cava = {
          enable = true;
          package = pkgs.cava;
          settings = {
            general = {
              framerate = 60;
              autosens = 1;
              sensitivity = 100;
              lower_cutoff_freq = 50;
              higher_cutoff_freq = 10000;
              # bar_width = 0.5;
            };
            output = {
              method = "ncurses";
            };
            smoothing = {
              monstercat = 1;
              waves = 1;
              noise_reduction = 88;
            };
          };
        };
      };
      stylix.targets.cava.rainbow.enable = true;
    };

}
