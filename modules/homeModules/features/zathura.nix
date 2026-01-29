{
  flake.homeModules.desktop =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {

      programs.zathura = {
        enable = true;
        package = pkgs.zathura.override {
          useMupdf = true;
        };

        options = {
          font = "monospace 10";
          selection-notification = true;
          selection-clipboard = "clipboard";
          statusbar-home-tilde = true;
          guioptions = "sv";
          scroll-page-aare = true;
          scroll-full-overlap = 0.2;
          adjust-open = "width";
          statusbar-h-padding = 10;
          statusbar-v-padding = 10;
          recolor = "false";
          recolor-keephue = "false";
          vertical-center = true;
          synctex = true;
          zoom-step = 3;
          window-title-basename = true;

          default-bg = lib.mkForce "#${config.lib.stylix.colors.base02}";
        };
      };
    };
}
