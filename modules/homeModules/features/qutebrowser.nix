{
  flake.homeModules.browser =
    { pkgs, ... }:
    {
      programs = {
        qutebrowser = {
          enable = true;

          settings = {
            # See the enableVulkan flag in the qutebrowser
            # overlay.
            # qt = {
            #   force_software_rendering = "chromium";
            # };

            # Can save lost stuff.
            auto_save = {
              session = true;
              interval = 20000;
            };

            tabs = {
              background = true;
              favicons.scale = 1.0;
            };
            window.transparent = true;
            downloads.position = "bottom";
            colors = {
              webpage = {
                preferred_color_scheme = "dark";
                darkmode = {
                  enabled = true;
                  policy.images = "never";
                };
              };
            };

            content = {
              autoplay = false;
              javascript.clipboard = "access";
              blocking = {
                enabled = true;
                method = "both";
                adblock.lists = [
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/experimental.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2025.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-general.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-mobile.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/lan-block.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/ubo-link-shorteners.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/ubol-filters.txt"
                  "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt"
                ];
              };
            };
          };

          # TODO: Add stuff here
          quickmarks = {
            # Options for NixOS
            nixconfig = "https://nixos.org/manual/nixos/stable/options.html";
            nixdisco = "https://discourse.nixos.org/";

            # For Other stuff
            youtube = "https://www.youtube.com/";
            moviesmod = "https://moviesmod.email/";
            reddit = "https://www.reddit.com/";
            letstype = "https://monkeytype.com/";
            letstype2 = "https://www.keybr.com/";
            whatsapp = "https://web.whatsapp.com/";
            rgba2hex = "https://rgbacolorpicker.com/rgba-to-hex";

            # PhysicsWallah
            pw = "https://www.pw.live/";
          };

          # Searchengines
          searchEngines = {
            chatgpt = "https://chat.openai.com/?q={}";
            wa = "https://wiki.archlinux.org/?search={}";
            yt = "https://www.youtube.com/results?search_query={}";
            mynixos = "https://mynixos.com/search?q={}";
            nixpackages = "https://search.nixos.org/packages?channel=25.05&query={}";
            nixoptions = "https://search.nixos.org/options?query={}";
            g = "https://www.google.co.in/search?q={}";
            gitrepo = "https://www.github.com/search?q={}&type=repositories";
            home-manager = "https://home-manager-options.extranix.com/?query={}&release=master";
          };

          keyBindings = {
            normal = {
              "yv" = "hint links spawn -ov ${pkgs.mpv}/bin/mpv {hint-url}";
              "yV" = "spawn -ov ${pkgs.mpv}/bin/mpv {url}";
              "yA" = "spawn -vo ${pkgs.mpv}/bin/mpv --force-window --no-video {url}";
              "ya" = "hint links spawn -vo ${pkgs.mpv}/bin/mpv --force-window --no-video {hint-url}";
            };
          };
        };
      };
    };
}
