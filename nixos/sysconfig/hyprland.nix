{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  programs = {
    dconf.enable = true;

    hyprland = {
      enable = true;
      withUWSM = true;
    };

    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
    };
  };

  security.pam.services = {
    hyprlock = { };
  };

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
                wallpaper = pkgs.fetchurl {
                  url = "https://github.com/AngelJumbo/gruvbox-wallpapers/blob/main/wallpapers/anime/anime_skull.png?raw=true";
                  hash = "sha256-cI8tgi0ADVpvWbk+8tTKA+4RmV1pdLNLfCdc5EUxQj4=";
                };
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
      defaultSession = "hyprland-uwsm";
    };
  };
}
