{
  flakes.nixosModules.niri =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      nixpkgs.overlays = [
        inputs.niri.overlays.niri
      ];

      imports = [
        inputs.niri.nixosModules.niri
      ];

      programs = {
        niri = {
          # To use the binary cache first let
          # the enable option be false
          # Add the inputs.niri-flake.nixosModules.niri to
          # imports and build once to let the binary cache
          # build. And then enable this option and rebuild.
          enable = true;

          # Use niri-stable and niri-unstable from sodiboo's cache
          # use niri from nixpkgs.
          package = pkgs.niri;
        };
      };

      # Use the niri polkit
      systemd.user.services.niri-flake-polkit.enable = true;

      # Enable swaylock pam authentication support
      security.pam.services.swaylock = { };

      # Enable the sodiboo official cache
      # if you wanna use niri from Sodiboo's cache
      # See how it's done here
      # https://github.com/sodiboo/niri-flake#binary-cache
      niri-flake.cache.enable = false;

      # Gets enabled by the niri-flake by default
      services.gnome.gnome-keyring.enable = true;
    };
}
