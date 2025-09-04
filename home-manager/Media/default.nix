{
  imports = [
    ./cava.nix
    ./cmus.nix
    ./mpv.nix
  ];

  services = {
    playerctld.enable = true;
  };
}
