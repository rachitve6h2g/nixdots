{ inputs, ... }:
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

        # For xdg-desktop-portal-termfilechooser
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        # Picked from https://wiki.nixos.org/wiki/COSMIC#Theming_and_Firefox
        "widget.gtk.libadwaita-colors.enabled" = false;

        "webgl.disabled" = false;
        "devtools.chrome.enabled" = true;
        "devtools.debugger.remote-enabled" = true;

        # Disable firefox looking for IPs of links that I haven't clicked yet
        "network.dns.disablePrefetch" = true;

        # Shift zen's tab list to ther right
        "zen.tabs.vertical.right-side" = true;

        "ui.systemUsesDarkTheme" = 1; # Signal to websites and UI that we prefer dark mode
        "browser.theme.content-theme" = 2; # Force internal pages (about:config, etc.) to be dark
        "layout.css.prefers-color-scheme.content-override" = 0; # Ensure web content respects the dark preference
        "zen.view.grey-out-inactive-windows" = false; # Prevents window dimming when focus shifts (essential for Tiling WMs)
        "zen.theme.content-element-separation" = 0; # Removes the border/gap around the web canvas for a flush look
        "browser.tabs.allow_transparent_browser" = true; # Enables transparency support for Zen's blur/glass themes

        "reader.parse-on-load.force-enabled" = true; # Forces Reader Mode availability on more sites

        "privacy.resistFingerprinting" = false; # Disabled: zen manages this better; avoids layout bugs in Zen's UI

        "browser.aboutConfig.showWarning" = false; # Skip the "I'll be careful" prompt for about:config
      };
      extensions = [
        # To add additional extensions, find it on addons.mozilla.org, find
        # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
        # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
        (extension "ublock-origin" "uBlock0@raymondhill.net")
        (extension "4263531" "myallychou@gmail.com")

        # (extension "material-gruvbox" "{818ee01c-662a-4214-bea9-ee3b02c5d950}")
        # (extension "kanagawa-dragon-dark-theme" "{a72ff906-b160-4ad5-a10a-5107f8f65846}")
        # (extension "tokyo-night-dark-theme" "{cebd391d-f568-473f-bb6e-698d08ec81ec}")

        # (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
        # (extension "clearurls" "{747302f2-fd31-4d06-bdc3-efb4d995951f}")
        # (extension "violentmonkey" "{77d2c305-3ee3-4309-b021-34a0239084ef}")
        # (extension "tabliss" "extension@tabliss.io")
      ];
    in
    {
      environment.systemPackages = [
        # To use firefox, in place of inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
        # place pkgs.firefox-unwrapped
        (pkgs.wrapFirefox
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
          {
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
              DisableBuiltinPDFViewer = true;
              DisableFirefoxScreenshots = true;
              DisableFormHistory = true;
              DisableForgetButton = true;
              DisableMasterPasswordCreation = true;
              DisableProfileImport = true;
              DisableProfileRefresh = true;
              DisableSetDesktopBackground = true;
              DontCheckDefaultBrowser = true;
              EnableTrackingProtection = {
                Value = true;
                Locked = true;
                Cryptomining = true;
                Fingerprinting = true;
                EmailTracking = true;
              };

              # Privacy
              HttpsOnlyMode = "force_enabled";

              # Disable "What's new" and "Feature Tour" after updates
              UserMessaging = {
                ExtensionRecommendations = false;
                SkipOnboarding = true;
                WhatsNew = false;
                FeatureRecommendations = false;
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
                  {
                    Name = "Gemini";
                    URLTemplate = "https://gemini.google.com/app?prompt={searchTerms}";
                    IconURL = "https://www.gstatic.com/lamda/images/favicon_v1_150160d1398865466e00.png";
                    Alias = "@gem";
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
          }
        )
      ];
    };
}
