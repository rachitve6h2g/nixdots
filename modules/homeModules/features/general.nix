{ inputs, ... }:
{
  flake.homeModules.general =
    { pkgs, config, ... }:
    {
      # NOTE: Please change stylix modules for NixOS
      # configuration as well. It's not yet been centralized
      # TODO: Centralize some stylix modules for home-manager
      # and NixOS configuration.
      # See $PROJECT_ROOT/hosts/Common/stylix.nix

      imports = [ inputs.stylix.homeModules.stylix ];

      # Extra fonts and theme packages that are needed.
      home = {
        packages = with pkgs; [
          nerd-fonts.symbols-only
        ];

        sessionVariables = {
          QT_QPA_PLATFORM = "wayland";
        };
      };

      # Extra fonts installed from home.packages are not detected unless:
      fonts = {
        fontconfig = {
          enable = true;
        };
      };

      qt.enable = true;

      stylix = {
        enable = true;

        # Obviously Cattppuccin
        # image = (
        #   pkgs.fetchurl {
        #     url = "https://raw.githubusercontent.com/rachitve6h2g/Wallpapers/main/catppuccin-13.png";
        #     hash = "sha256-fYMzoY3un4qGOSR4DMqVUAFmGGil+wUze31rLLrjcAc=";
        #   }
        # );

        image = (
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/atraxsrc/tokyonight-wallpapers/main/tokyonight_original.png";
            hash = "sha256-VmIsHCWQBegiHNQ8BtQAmt3Da5cvR3aVc/sGHIIenEI=";
          }
        );

        base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
        polarity = "dark";

        fonts = {
          sizes = {
            terminal = 12;
          };
          monospace = {
            package = pkgs.maple-mono.NF;
            name = "Maple Mono NF";
          };
          serif = config.stylix.fonts.monospace;
          sansSerif = config.stylix.fonts.monospace;
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
        };

        icons = {
          enable = true;
          package = (pkgs.papirus-icon-theme.override { color = "blue"; });
          /*
            (
              pkgs.catppuccin-papirus-folders.override {
                flavor = "mocha";
                accent = "mauve";
              }
            );
          */

          light = "Papirus-Dark";
          dark = config.stylix.icons.light;
        };

        cursor = {
          package = pkgs.bibata-cursors;
          size = 24;
          name = "Bibata-Modern-Ice";
        };

        targets = {
          qt = {
            enable = true;
            platform = "qtct";
            standardDialogs = "xdgdesktopportal";
          };
        };

        opacity = {
          terminal = 0.89;
          popups = 0.9;
        };
      };
    };
}
