{ self, ... }:
let
  inherit (self) themeNoHash;
in
{
  perSystem = {
    wrappers.packages.mpv = true;
  };

  flake.wrappers.mpv =
    { wlib, pkgs, ... }:
    {
      imports = [ wlib.wrapperModules.mpv ];
      scripts = with pkgs.mpvScripts; [
        mpris
        uosc
        sponsorblock
      ];
      package = pkgs.mpv.override {
        mpv-unwrapped = pkgs.mpv-unwrapped.override {
          ffmpeg = pkgs.ffmpeg-full;
          bluraySupport = false;
          x11Support = false;
          waylandSupport = true;
          vdpauSupport = false;
        };
      };
      "mpv.conf".content = with themeNoHash; ''
        background-color='#000000'
        keep-open=yes
        osd-back-color='#${base01}'
        osd-border-color='#${base01}'
        osd-color='#${base05}'
        osd-font=Maple Mono NF
        osd-shadow-color='#${base00}'
        save-position-on-quit=yes
        sub-font=Maple Mono NF

        script-opts-append=stats-border_color=251818
        script-opts-append=stats-font_color=f4d6cd
        script-opts-append=stats-plot_bg_border_color=f7a6cb
        script-opts-append=stats-plot_bg_color=251818
        script-opts-append=stats-plot_color=f7a6cb

        # External script options
        # It is fine to leave these here even if one does not use these scripts because they are just ignored unless a script uses them

        # UOSC options
        script-opts-append=uosc-color=foreground=${base0E},foreground_text=${base05},background=${base00},background_text=${base05},curtain=${base01},success=${base0B},error=${base08}
      '';
    };
}
