{
  flake.nixosModules.firefox =
    {
      pkgs,
      lib,
      ...
    }:
    let
      extension = shortId: guid: {
        name = guid;
        value = {
          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      prefs = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "extensions.autoDisableScopes" = 0;
        "extensions.pocket.enabled" = false;
        "extensions.pocket.showHome" = false;
        "browser.newtabpage.activity-stream.discoverystream.saveToPocketCard.enabled" = false;
        "browser.newtabpage.activity-stream.discoverystream.personalization.enabled" = false;
        "browser.newtabpage.activity-stream.showSearch" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;

        # For xdg-desktop-portal-termfilechooser
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        # Picked from https://wiki.nixos.org/wiki/COSMIC#Theming_and_Firefox
        "widget.gtk.libadwaita-colors.enabled" = false;

        "webgl.disabled" = false;
        "devtools.chrome.enabled" = true;
        "devtools.debugger.remote-enabled" = true;
      };

      extensions = [
        # To add additional extensions, find it on addons.mozilla.org, find
        # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
        # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
        (extension "ublock-origin" "uBlock0@raymondhill.net")
        (extension "4263531" "myallychou@gmail.com")
        (extension "darkreader" "addon@darkreader.org")
        # (extension "material-gruvbox" "{818ee01c-662a-4214-bea9-ee3b02c5d950}")
        (extension "kanagawa-dragon-dark-theme" "{a72ff906-b160-4ad5-a10a-5107f8f65846}")
      ];
    in
    {
      environment.systemPackages = [
        (pkgs.wrapFirefox pkgs.firefox-unwrapped {
          extraPrefs = lib.concatLines (
            lib.mapAttrsToList (
              name: value: "lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value})"
            ) prefs
          );

          extraPolicies = {
            ExtensionSettings = builtins.listToAttrs extensions;

            # Updates and background services
            AppAutoUpdate = false;
            DisableAppUpdate = true;
            BackgroundAppUpdate = false;

            # Feature Disabling
            DisableTelemetry = true;
            DisableBuiltinPDFViewer = true;
            DisableFirefoxStudies = true;
            DisableFirefoxScreenshots = true;
            DisableFormHistory = true;
            DisableForgetButton = true;
            DisableMasterPasswordCreation = true;
            DisableProfileImport = true;
            DisableProfileRefresh = true;
            DisablePocket = true;
            DisableSetDesktopBackground = true;
            DontCheckDefaultBrowser = true;
            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              Fingerprinting = true;
              EmailTracking = true;
            };

            # Access Restrictions
            BlockAboutConfig = false;
            BlockAboutProfiles = true;
            BlockAboutSupport = true;

            # DefaultDownloadDirectory = "${config.xdg.userDirs.download}";

            ExtensionUpdate = true;
            HardwareAcceleration = true;
            PDFjs = {
              Enabled = false;
              EnablePermissions = false;
            };

            Permissions = {
              Camera = {
                Allow = [ ];
                BlockNewRequests = true;
                Locked = true;
              };

              Microphone = {
                Allow = [ ];
                BlockNewRequests = true;
                Locked = true;
              };
              Location = {
                Allow = [ ];
                BlockNewRequests = true;
                Locked = true;
              };
            };

            SearchEngines = {
              Default = "ddg";
              Add = [
                # NixOS Related
                {
                  Name = "nixpkgs packages";
                  URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@np";
                }
                {
                  Name = "NixOS options";
                  URLTemplate = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@no";
                }
                {
                  Name = "NixOS Wiki";
                  URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@nw";
                }
                {
                  Name = "noogle";
                  URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                  IconURL = "https://noogle.dev/favicon.ico";
                  Alias = "@ng";
                }

                # Non-NixOS
                {
                  Name = "Arch Wiki";
                  URLTemplate = "https://wiki.archlinux.org/index.php?search={searchTerms}";
                  IconURL = "https://archlinux.org/favicon.ico";
                  Alias = "@alwiki";
                }

                # Github shortcuts
                {
                  Name = "Git Repos";
                  URLTemplate = "https://github.com/search?q={searchTerms}&type=repositories";
                  IconURL = "https://github.com/favicon.ico";
                  Alias = "@gitrepo";
                }
                {
                  Name = "Git Code";
                  URLTemplate = "https://github.com/search?q={searchTerms}&type=code";
                  IconURL = "https://github.com/favicon.ico";
                  Alias = "@gitcode";
                }

                # AI for use
                {
                  Name = "ChatGPT";
                  URLTemplate = "https://chatgpt.com/?q={searchTerms}";
                  IconURL = "https://chatgpt.com/favicon.ico";
                  Alias = "@gpt";
                }
                {
                  Name = "Perplexity";
                  URLTemplate = "https://www.perplexity.ai/?q={searchTerms}";
                  IconURL = "https://www.perplexity.ai/favicon.ico";
                  Alias = "@perplex";
                }

                # YouTube
                {
                  Name = "YouTube Music";
                  URLTemplate = "https://music.youtube.com/search?q={searchTerms}";
                  IconURL = "https://music.youtube.com/favicon.ico";
                  Alias = "@ytm";
                }
                {
                  Name = "YouTube";
                  URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
                  IconURL = "https://www.youtube.com/favicon.ico";
                  Alias = "@ytv";
                }
              ];
            };
          };
        })
      ];
    };
}
