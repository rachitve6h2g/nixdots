{
  imports = [
    ./adb.nix
    ./battery.nix
    ./bluetooth.nix
    ./boot-loader.nix
    ./btrfs-autoscrub.nix
    ./cleanup.nix
    ./compileopts.nix
    ./consolekeymap.nix
    ./fingerprint.nix
    ./gaming.nix
    ./graphics.nix
    ./kdeconnect.nix
    ./keymap.nix
    ./networking.nix
    ./nh.nix
    ./niri.nix
    ./nix-index.nix
    ./plymouth.nix
    ./sddm.nix
    ./security.nix
    ./sound.nix
    ./ssh.nix
    ./system-stylix.nix
    ./system.nix
    ./thunar.nix
    ./tmp_on_ram.nix
    ./user.nix
    ./virtualization.nix
    ./zram.nix
  ];

  documentation.man.generateCaches = false;

  # Add $HOME/.local/bin to the $PATH variable.
  environment.localBinInPath = true;
}
