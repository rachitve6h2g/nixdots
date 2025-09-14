{
  config,
  pkgs,
  ...
}:
{
  programs = {
    firefox = {
      enable = true;

      enableGnomeExtensions = false;

      nativeMessagingHosts = with pkgs; [ firefoxpwa ];

      policies = {
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

        DefaultDownloadDirectory = "${config.xdg.userDirs.download}";

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

        # If not available in NUR.
        ExtensionSettings =
          let
            moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
          in
          {
            # Unhook, YouTube suggestions removed.
            "myallychou@gmail.com" = {
              install_url = moz "4263531";
              installation_mode = "force_installed";
              private_browsing = "true";
            };
          };

        # about:config settings defined globally
        Preferences = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Disable the pocket extension, and the home-feed.
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
        };
      };

      profiles = {
        krish = {
          name = "krish";
          isDefault = true;

          search = {
            force = true;

            default = "ddg";
            privateDefault = "ddg";

            engines = {
              nixos-wiki = {
                name = "NixOS Wiki";
                urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
                iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
                definedAliases = [ "@nw" ];
              };

              nix-packages = {
                name = "Nix Packages";
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };

              home-manager-options = {
                name = "Home Manager Options";
                urls = [
                  {
                    template = "https://home-manager-options.extranix.com";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                      {
                        name = "release";
                        value = "master";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@hmopts" ];
              };

              mynixos = {
                name = "MyNixOS";
                urls = [
                  {
                    template = "https://mynixos.com/search";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

                definedAliases = [ "@mynixos" ];
              };

              archwiki = {
                name = "ArchWiki";
                urls = [
                  {
                    template = "https://wiki.archlinux.org/index.php";
                    params = [
                      {
                        name = "search";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "https://archlinux.org/static/logos/legacy/arch-legacy-blue2.svg";
                definedAliases = [ "@alwiki" ];
              };

              gentoowiki = {
                name = "Gentoo Wiki";
                urls = [
                  {
                    template = "https://wiki.gentoo.org/index.php";
                    params = [
                      {
                        name = "search";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                iconMapObj."16" = "https://wiki.gentoo.org/images/d/dd/Genchu.png";
                definedAliases = [ "@gwiki" ];
              };

              gitrepos = {
                name = "Git Repos";
                urls = [
                  {
                    template = "https://github.com/search";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                      {
                        name = "type";
                        value = "repositories";
                      }
                    ];
                  }
                ];
                iconMapObj."16" = "https://github.githubassets.com/assets/GitHub-Mark-ea2971cee799.png";
                definedAliases = [ "@gitrepo" ];
              };

              chatgpt = {
                name = "ChatGpt";
                urls = [
                  {
                    template = "https://chat.openai.com/?q={searchTerms}";
                  }
                ];

                iconMapObj."16" = "https://chat.openai.com/favicon.ico";
                definedAliases = [ "@gpt" ];
              };

              youtube = {
                name = "YouTube";
                urls = [ { template = "https://www.youtube.com/results?search_query={searchTerms}"; } ];
                definedAliases = [ "@yt" ];
              };

              bing.metaData.hidden = true;
              google.metaData.alias = "@g";
            };
          };
          settings = {
            "extensions.autoDisableScopes" = 0; # This will automatically enable installed extensions
            "webgl.disabled" = false;
          };

          bookmarks = {
            force = true;
            settings = [
              {
                name = "wikipedia";
                tags = [ "wiki" ];
                keyword = "wiki";
                url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
              }

              {
                name = "kernel.org";
                url = "https://www.kernel.org";
              }

              {
                name = "Nix sites";
                toolbar = true;
                bookmarks = [
                  {
                    name = "homepage";
                    url = "https://nixos.org/";
                  }

                  {
                    name = "wiki";
                    tags = [
                      "wiki"
                      "nix"
                    ];
                    url = "https://wiki.nixos.org/";
                  }
                ];
              }

              {
                name = "Social";
                toolbar = true;
                bookmarks = [
                  {
                    name = "whatsapp";
                    url = "web.whatsapp.com";
                  }
                ];
              }
              {
                name = "Study";
                toolbar = true;
                bookmarks = [
                  {
                    name = "chatgpt";
                    url = "https://chatgpt.com";
                  }
                  {
                    name = "Physics Wallah";
                    url = "https://www.pw.live";
                  }
                ];
              }
            ];

          };
          extensions = {
            force = true;

            packages = with pkgs.nur.repos.rycee.firefox-addons; [
              localcdn
              stylus
              ublock-origin
              facebook-container
            ];

            settings = {
              "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
                force = true;
                settings = {
                  dbInChromeStorage = true;
                };
              };

              "uBlock0@raymondhill.net" = {
                force = true;
                settings = {
                  selectedFilterLists = [
                    "ublock-filters"
                    "ublock-badware"
                    "ublock-privacy"
                    "ublock-unbreak"
                    "ublock-quick-fixes"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };

  # firefox stylix module:
  stylix.targets.firefox = {
    profileNames = [ "krish" ];
  };
}
