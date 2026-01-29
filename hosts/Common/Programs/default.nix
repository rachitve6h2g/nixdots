{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      # Downloaders
      wget
      curl

      # Editors (emacs has a different file)
      vim # Use vim

      # 
      ( git.override { withLibsecret = true; })
    ];
  };

  # Disable nano, use vim for small editings here and there.
  programs.nano.enable = false;

  imports = [
    ./adb.nix
    ./blueman.nix
    # ./gaming.nix
    ./kdeconnect.nix
    ./locate.nix
    ./nh.nix
    ./nix-index.nix
    ./plymouth.nix
    ./ssh.nix
    ./sudo.nix
    ./sudo.nix
    ./thunar.nix
    # ./virtualization.nix
  ];
}
