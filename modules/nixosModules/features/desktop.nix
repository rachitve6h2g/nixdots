{ self, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.battery
        self.nixosModules.clamav
        self.nixosModules.console
        self.nixosModules.greeter
        self.nixosModules.keymap
        self.nixosModules.kmscon
        self.nixosModules.locale
        self.nixosModules.niri
        self.nixosModules.nix
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

      xdg = {
        sounds.enable = true;
        portal.wlr.enable = true;
      };

      security.polkit.enable = true;

      services = {
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
