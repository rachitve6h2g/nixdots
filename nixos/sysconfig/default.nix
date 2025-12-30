{ pkgs, ... }:
{
  imports = [
    ./adb.nix
    ./battery.nix
    ./bluetooth.nix
    ./boot-loader.nix
    ./btrfs-autoscrub.nix
    ./clamav.nix
    ./cleanup.nix
    ./compileopts.nix
    ./consolekeymap.nix
    ./fingerprint.nix
    # ./gaming.nix
    ./graphics.nix
    ./kdeconnect.nix
    ./keymap.nix
    ./networking.nix
    ./nh.nix
    ./niri.nix
    ./nix-index.nix
    ./plymouth.nix
    ./security.nix
    ./sound.nix
    ./ssh.nix
    ./system-stylix.nix
    ./system.nix
    ./thunar.nix
    ./tmp_on_ram.nix
    ./user.nix
    ./virtualization.nix
    ./xdg.nix
    # ./zram.nix
    ./zswap.nix
  ];

  documentation.man.generateCaches = false;

  # Add $HOME/.local/bin to the $PATH variable.
  environment = {
    localBinInPath = true;
    variables = {
      QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt6.qtbase.outPath}/lib/qt-6/plugins";
    };
    # Required by programs.bash.enableCompletion in home-manager.
    pathsToLink = [ "/share/bash-completion" ];
  };
}
