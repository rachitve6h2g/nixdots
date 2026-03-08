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
        self.nixosModules.extra_hjem
        self.nixosModules.firefox
        self.nixosModules.fonts
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
      environment = {
        # TOOD: move all the wrapped packages into their own modules
        sessionVariables = {
          EDITOR = "hx";
          VISUAL = "hx";
        };
        systemPackages = [
          selfpkgs.aria2 # TRACK: https://github.com/BirdeeHub/nix-wrapper-modules/discussions/317#discussioncomment-15975516
          selfpkgs.mpv
          selfpkgs.noctalia-shell
          selfpkgs.wezterm
          selfpkgs.git
          selfpkgs.helix
          selfpkgs.yt-dlp
          selfpkgs.xplr
          selfpkgs.zathura

          pkgs.wl-clipboard
          pkgs.brightnessctl
          pkgs.libnotify
          pkgs.gdu
          pkgs.udiskie
          pkgs.polkit_gnome
          pkgs._7zz-rar
          pkgs.nvfetcher # For updating sources of custom packages
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
