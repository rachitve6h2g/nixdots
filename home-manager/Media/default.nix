{
  imports = [
    ./beets.nix
    ./cava.nix
    # ./cmus.nix
    ./mpd.nix
    ./mpv.nix
    ./rmpc.nix
  ];

  services = {
    playerctld.enable = true;
  };
}
