{ pkgs, ... }:
{
  imports = [
    ./bottom.nix
    ./btop.nix
    ./clock-rs.nix
    ./fastfetch.nix
    ./gcc.nix
    ./irssi.nix
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
    bluetui
    cheese
    gthumb
    impala
    (uget.override {
      aria2 = pkgs.aria2;
    })
    wgetpaste
    wiremix
    wl-clipboard
  ];

  programs = {
    jq = {
      enable = true;
    };
  };
}
