{
  flake.nixosModules.gtk =
    { pkgs, ... }:
    let
      theme-name = "Kanagawa-BL"; # Borderless
      theme-package = pkgs.kanagawa-gtk-theme;

      icon-theme-package = pkgs.kanagawa-icon-theme;
      icon-theme-name = "Kanagawa";

      cursor-package = pkgs.bibata-cursors;
      cursor-name = "Bibata-Modern-Ice";

      gtksettings = ''
        [Settings]
        gtk-cursor-theme-name=${cursor-name}
        gtk-cursor-theme-size=24
        gtk-font-name=JetBrainsMono Nerd Font 12
        gtk-icon-theme-name=${icon-theme-name}
        gtk-theme-name=${theme-name}
      '';

      # For later use with hjem
      /*
        gtk2Settings = ''
          gtk-cursor-theme-name = "Bibata-Modern-Ice"
          gtk-cursor-theme-size = 24
          gtk-font-name = "DejaVu Sans 12"
          gtk-icon-theme-name = "Gruvbox-Plus-Dark"
          gtk-theme-name = "adw-gtk3"
        '';
      */
    in
    {
      xdg.icons.enable = true;
      xdg.sounds.enable = true;

      gtk.iconCache.enable = true;
      environment = {
        etc = {
          "xdg/gtk-3.0/settings.ini".text = gtksettings;
          "xdg/gtk-4.0/settings.ini".text = gtksettings;
        };
        variables = {
          GTK_THEME = theme-name;
        };
        systemPackages = [
          theme-package
          icon-theme-package
          pkgs.gtk3
          pkgs.gtk4
        ];
      };

      programs = {
        dconf = {
          enable = true;
          profiles = {
            user = {
              databases = [
                {
                  lockAll = false;
                  settings = {
                    "org/gnome/desktop/interface" = {
                      gtk-theme = theme-name;
                      icon-theme = icon-theme-name;
                      color-scheme = "prefer-dark";
                    };
                  };
                }
              ];
            };
          };
        };
      };
    };
}
