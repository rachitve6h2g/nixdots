{ self, ... }:
{
  flake.homeModules.desktop =
    {
      pkgs,
      config,
      ...
    }:
    {

      imports = [
        self.homeModules.discord
        self.homeModules.noctalia
        self.homeModules.zen-browser
      ];

      home.packages = with pkgs; [
        wl-clipboard
        brightnessctl
        libnotify

        gdu # For disk usage anlaysis
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
            default = [ "footclient.desktop" ];
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
