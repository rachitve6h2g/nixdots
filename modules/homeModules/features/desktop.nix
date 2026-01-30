{ self, ... }:
{
  flake.homeModules.desktop =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {

      imports = [
        self.homeModules.firefox
      ];

      home.packages = with pkgs; [
        wl-clipboard
        brightnessctl
        libnotify
      ];
      services = {
        udiskie = {
          enable = true;
          automount = true;
          notify = true;
          tray = "never";

          settings = {
            programs_options = {
              udisks_version = 2;
              tray = false;
            };
            icon_names.media = [ "media-optical" ];
          };
        };
        polkit-gnome = {
          enable = false;
        };
        poweralertd.enable = true;

        cliphist = {
          enable = true;
          allowImages = true;
          extraOptions = [
            "-max-dedupe-search"
            "10"
            "-max-items"
            "100"
          ];
        };

        fnott = {
          enable = true;
          settings = lib.mkAfter {
            main = {
              play-sound = "pw-play --volume 0.6 \${filename}";
              sound-file = "${pkgs.kdePackages.ocean-sound-theme}/share/sounds/ocean/stereo/message-attention.oga";
              icon-theme = config.stylix.icons.light;

              border-radius = 50;
              scaling-filter = "lanczos3";
              layer = "top";
              default-timeout = 3;
            };

            critical = {
              sound-file = "${pkgs.kdePackages.ocean-sound-theme}/share/sounds/ocean/stereo/dialog-error-serious.oga";
              layer = "overlay";
              idle-timeout = 5;
            };
          };

          extraFlags = [
            "-s" # Disable logging to syslog
          ];
        };
      };

      xdg = {
        enable = true;
        dataHome = "${config.home.homeDirectory}/.local/share";
        stateHome = "${config.home.homeDirectory}/.local/state";
        cacheHome = "${config.home.homeDirectory}/.cache";
        configHome = "${config.home.homeDirectory}/.config";

        mime = {
          enable = true;
        };
        mimeApps = {
          enable = true;

          defaultApplications =
            let
              defaultBrowser = "firefox.desktop";
            in
            {
              "application/pdf" = "org.pwmt.zathura-pdf.desktop";
              "application/vnd.comicbook" = "org.pwmt.zathura.desktop";
              "application/zip" = "7zz";
              "image/png" = "swayimg.desktop";
              "image/jpeg" = "swayimg.desktop";
              "x-scheme-handler/terminal" = "kitty.desktop";
              "text/html" = defaultBrowser;
              "x-scheme-handler/http" = defaultBrowser;
              "x-scheme-handler/https" = defaultBrowser;
              "x-scheme-handler/about" = defaultBrowser;
              "x-scheme-handler/unknown" = defaultBrowser;
            };
        };

        systemDirs = {
          data = [
            "/usr/share"
            "/usr/local/share"
          ];

          config = [ "/etc/xdg" ];
        };

        userDirs = {
          enable = true;
          createDirectories = true;
        };

        terminal-exec = {
          enable = true;
          settings = {
            default = [ "kitty.desktop" ];
          };
        };

        portal = {
          enable = true;
          xdgOpenUsePortal = true;
          extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
          ];
        };
      };
    };
}
