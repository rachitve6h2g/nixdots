{ self, ... }:

{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      imports = [
        self.nixosModules.battery
        self.nixosModules.clamav
        self.nixosModules.console
        self.nixosModules.hjem
        self.nixosModules.firefox
        self.nixosModules.fonts
        self.nixosModules.greeter
        self.nixosModules.gtk
        self.nixosModules.kdeconnect
        self.nixosModules.keymap
        self.nixosModules.locale
        self.nixosModules.nix
        self.nixosModules.commonPackages
        self.nixosModules.sound
      ];
      programs = {
        thunar = {
          enable = true;
          plugins = with pkgs; [
            thunar-archive-plugin
            thunar-volman
            thunar-vcs-plugin
            thunar-media-tags-plugin
          ];
        };
        dconf.enable = true;
      };
      environment = {
        systemPackages = [
          selfpkgs.mpv
          selfpkgs.noctalia-bundle
          selfpkgs.wezterm

          pkgs.wl-clipboard
          pkgs.brightnessctl
          pkgs.libnotify
          pkgs.udiskie
          pkgs.polkit_gnome

          # For music
          pkgs.lrcget # Get the lyrics for any song
        ];
      };

      xdg = {
        sounds.enable = true;
        portal.wlr.enable = true;
      };

      security.polkit.enable = true;

      services = {
        playerctld.enable = true;
        locate = {
          enable = true;
          package = pkgs.plocate;
        };
        gvfs = {
          enable = true;
          package = pkgs.gvfs.override { gnomeSupport = false; };
        };
        tumbler.enable = true;
        blueman.enable = true;
      };
    };
}
