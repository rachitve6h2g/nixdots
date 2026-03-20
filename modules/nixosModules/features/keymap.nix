{
  flake.nixosModules.keymap = {
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak_dh";
      options = "ctrl:swapcaps";
    };
  };
}
