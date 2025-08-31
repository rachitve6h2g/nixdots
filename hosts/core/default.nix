{
  imports = [
    ./autoupgrade.nix
    ./battery.nix
    ./bluetooth.nix
    ./boot-loader.nix
    ./btrfs-autoscrub.nix
    ./cleanup.nix
    ./compileopts.nix
    ./consoleKeymap.nix
    ./graphics.nix
    ./kdeconnect.nix
    ./keymap.nix
    ./networking.nix
    ./nh.nix
    ./nix.nix
    ./nix-index.nix
    ./plymouth.nix
    ./security.nix
    ./sound.nix # comment this out if using in VM
    # Otherwise the sound in host will stop working
    ./stylix.nix
    ./system.nix
    ./thunar.nix
    ./user.nix
    # ./virtmanager.nix
    ./vivid.nix
    ./zram.nix

    ./Desktop
  ];
}
