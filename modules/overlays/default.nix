{
  imports = [
    ./hyprland.nix
    ./nix-emacs.nix
    ./nur.nix
    ./qutebrowser.nix
    # ./unstablepkgs.nix # Not needed if nixpkgs.url = "<some unstable nixos channel>". See flake.nix first
  ];
}
