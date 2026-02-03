{
  flake.homeModules.shell =
    { pkgs, ... }:
    {
      programs.yazi = {
        enable = true;
        package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; };
        enableBashIntegration = true;
        shellWrapperName = "y";

        settings = {
          yazi = {
            ratio = [
              1
              4
              3
            ];

            sort_by = "natural";
            sort_sensitive = true;
            sort_reverse = false;
            sort_dir_first = true;
            linemode = "none";
            show_hidden = true;
            show_symlink = true;
          };

          preview = {
            image_filter = "lanczos3";
            image_quality = 90;
            tab_size = 1;
            max_width = 600;
            max_height = 900;
            cache_dir = "";
            ueberzug_scale = 1;
            ueberzeg_offset = [
              0
              0
              0
              0
            ];
            tasks = {
              micro_workers = 5;
              macro_workers = 10;
              bizarre_retry = 5;
            };
          };
        };
      };
    };
}
