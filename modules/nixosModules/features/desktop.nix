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
        self.nixosModules.firefox
        self.nixosModules.fonts
        # self.nixosModules.gaming
        self.nixosModules.greeter
        self.nixosModules.gtk
        self.nixosModules.kdeconnect
        self.nixosModules.keymap
        self.nixosModules.locale
        self.nixosModules.nix
        self.nixosModules.social
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

      environment.systemPackages = [
        # Wrapped packages
        selfpkgs.aria2.out # FIXME: fix the binary wrapper problem
        selfpkgs.foot
        selfpkgs.mpv
        selfpkgs.git
        selfpkgs.yt-dlp

        pkgs.wl-clipboard
        pkgs.brightnessctl
        pkgs.libnotify
        pkgs.gdu
        pkgs.udiskie
        pkgs.polkit_gnome
      ];

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
