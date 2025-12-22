{ pkgs, ... }:
{
  imports = [
    ./btop.nix
    ./clock-rs.nix
    ./gcc.nix
    ./irssi.nix
    ./newsboat.nix
    ./nix-search-tv.nix
    ./nix-init.nix
    ./ollama.nix
    ./onlyoffice.nix
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
    discord-ptb
    # freecad-wayland # for trying out for my brother
    gnome-calculator
    gthumb
    impala
    microfetch # Patch for customization
    seahorse
    speedtest-rs
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
