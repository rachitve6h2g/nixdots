{ pkgs, ... }:
{
  programs.anyrun = {
    enable = true;
    config = {
      x = {
        fraction = 0.5;
      };
      y = {
        absolute = 0;
      };
      width = {
        absolute = 800;
      };
      height = {
        absolute = 1;
      };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;

      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libsymbols.so"
        "${pkgs.anyrun}/lib/libniri_focus.so"
        "${pkgs.anyrun}/lib/libnix_run.so"
      ];
    };

    # Inline comments are supported for language injection into
    # multi-line strings with Treesitter! (Depends on your editor)
    # extraCss = /* css */ ''
    #   /* GTK Vars */
    #   @define-color bg-color #313244;
    #   @define-color fg-color #cdd6f4;
    #   @define-color primary-color #89b4fa;
    #   @define-color secondary-color #cba6f7;
    #   @define-color border-color @primary-color;
    #   @define-color selected-bg-color @primary-color;
    #   @define-color selected-fg-color @bg-color;
    #
    #   * {
    #     all: unset;
    #     font-family: JetBrainsMono Nerd Font;
    #   }
    #
    #   #window {
    #     background: transparent;
    #   }
    #
    #   box#main {
    #     border-radius: 16px;
    #     background-color: alpha(@bg-color, 0.6);
    #     border: 0.5px solid alpha(@fg-color, 0.25);
    #   }
    #
    #   entry#entry {
    #     font-size: 1.25rem;
    #     background: transparent;
    #     box-shadow: none;
    #     border: none;
    #     border-radius: 16px;
    #     padding: 16px 24px;
    #     min-height: 40px;
    #     caret-color: @primary-color;
    #   }
    #
    #   list#main {
    #     background-color: transparent;
    #   }
    #
    #   #plugin {
    #     background-color: transparent;
    #     padding-bottom: 4px;
    #   }
    #
    #   #match {
    #     font-size: 1.1rem;
    #     padding: 2px 4px;
    #   }
    #
    #   #match:selected,
    #   #match:hover {
    #     background-color: @selected-bg-color;
    #     color: @selected-fg-color;
    #   }
    #
    #   #match:selected label#info,
    #   #match:hover label#info {
    #     color: @selected-fg-color;
    #   }
    #
    #   #match:selected label#match-desc,
    #   #match:hover label#match-desc {
    #     color: alpha(@selected-fg-color, 0.9);
    #   }
    #
    #   #match label#info {
    #     color: transparent;
    #     color: @fg-color;
    #   }
    #
    #   label#match-desc {
    #     font-size: 1rem;
    #     color: @fg-color;
    #   }
    #
    #   label#plugin {
    #     font-size: 16px;
    #   }
    # '';

    # extraConfigFiles."some-plugin.ron".text = ''
    #   Config(
    #     // for any other plugin
    #     // this file will be put in ~/.config/anyrun/some-plugin.ron
    #     // refer to docs of xdg.configFile for available options
    #   )
    # '';
  };
}
