{
  flake.nixosModules.gtk =
    { pkgs, ... }:
    let
      theme-name = "Tokyonight-Purple-Dark"; # Borderless
      theme-package = pkgs.tokyonight-gtk-theme.override {
        gnome-shell = null; # Don't install Gnome Shell
        gnome-themes-extra = null; # Don't install gnome-themes-extra
        colorVariants = [ "dark" ];
        sizeVariants = [ "standard" ];
        themeVariants = [ "purple" ];
        tweakVariants = [
          "macos"
          "black"
        ];
        iconVariants = [ "Dark" ];
      };

      # icon-theme-package = pkgs.kanagawa-icon-theme;
      icon-theme-name = "Tokyonight-Dark";

      cursor-package = pkgs.bibata-cursors;
      cursor-name = "Bibata-Modern-Ice";

      gtksettings = ''
        [Settings]
        gtk-cursor-theme-name=${cursor-name}
        gtk-cursor-theme-size=24
        gtk-font-name=Iosevka Nerd Font 12
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
          XCURSOR_THEME = cursor-name;
        };
        systemPackages = [
          theme-package
          # icon-theme-package
          cursor-package
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
                  lockAll = true;
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
