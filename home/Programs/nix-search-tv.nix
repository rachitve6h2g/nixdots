{
  programs = {
    nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;

      settings = {
        indexes = [
          "nixpkgs"
          "home-manager"
          "nixos"
        ];
        # experimental = {
        #   render_docs_indexes = {
        #   };
        # };
      };
    };

    television = {
      enable = true;
      # TODO: write the settings.
      #
      # settings = {
      #   tick_rate = 50;
      #   ui = {
      #     use_nerd_font_icons = true;
      #     ui_scale = 120;
      #     show_preview_panel = false;
      #   };
      #   keybindings = {
      #     quit = [
      #       "esc"
      #       "ctrl-c"
      #     ];
      #   };
      # };
    };
  };
}
