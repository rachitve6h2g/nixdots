{
  flake.homeModules.media =
    { pkgs, ... }:
    {
      services = {
        playerctld.enable = true; # Control mpris with media hotkeys
      };

      programs = {
        mpv = {
          enable = true;

          package = (
            pkgs.mpv.override {
              scripts = with pkgs.mpvScripts; [
                mpris
                uosc
                sponsorblock
              ];
              mpv-unwrapped = pkgs.mpv-unwrapped.override {
                ffmpeg = pkgs.ffmpeg-full;
                bluraySupport = false;
                x11Support = false;
                waylandSupport = true;
                vdpauSupport = false;
              };
            }
          );

          config = {
            save-position-on-quit = true;
            keep-open = true;
          };
        };
      };
      stylix.targets.cava.rainbow.enable = true;
    };

}
