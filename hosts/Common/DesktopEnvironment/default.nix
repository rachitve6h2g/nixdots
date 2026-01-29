{
  imports = [
    ./greeter.nix

    # Remember to change the greeter's
    # session directory.
    # ./hyprland.nix
    ./niri.nix
  ];

  programs.dconf.enable = true;
  xdg = {
    sounds.enable = true;
    portal.wlr.enable = true;
  };
  security.polkit.enable = true;
}
