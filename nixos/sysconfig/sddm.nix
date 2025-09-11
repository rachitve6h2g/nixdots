{
  inputs,
  config,
  lib,
  ...
}:
{
  # Sddm display manager
  imports = [ inputs.sddm-sugar-candy-nix.nixosModules.default ];

  nixpkgs.overlays = [
    inputs.sddm-sugar-candy-nix.overlays.default
  ];

  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
        settings = {
          General.DisplayServer = "wayland";
        };
        sugarCandyNix = {
          enable = true;
          settings = {
            Background =
              let
                # Use ~/.dotfiles/home-manager/Niri/wallpaper.nix source.
                wallpaper = config.home-manager.users.krish.stylix.image;
              in
              lib.cleanSource wallpaper;
            ScreenWidth = 1920;
            ScreenHeight = 1080;
            FormPosition = "right";
            HaveFormBackground = true;
            PartialBlur = true;
          };
        };
      };
      defaultSession = "niri-uwsm";
    };
  };
}
