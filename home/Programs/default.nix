{ pkgs, ... }:
{
  imports = [
    ./bottom.nix
    ./btop.nix
    ./clock-rs.nix
    ./fastfetch.nix
    ./gcc.nix
    ./kdeconnect.nix
    ./newsboat.nix
    ./nix-search-tv.nix
    ./nix-init.nix
    ./swayimg.nix
    ./trash-cli.nix
    ./udiskie.nix
    ./yt-dlp.nix
    ./zathura.nix

    ./wgetpaste
    ./yazi
  ];

  # Misc
  home.packages = with pkgs; [
    ansifilter
    bluetuith
    gthumb
    impala
    (uget.override {
      aria2 = pkgs.aria2;
    })
    wgetpaste
    wiremix
  ];

  programs = {
    jq = {
      enable = true;
    };
  };
}
