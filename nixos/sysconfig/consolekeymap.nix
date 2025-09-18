{ pkgs, ... }:
{
  console = {
    enable = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132b.psf.gz";
    keyMap = "mod-dh-ansi-us";
    earlySetup = true;
    # useXkbConfig = true;
  };
}
