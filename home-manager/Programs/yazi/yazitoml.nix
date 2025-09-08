{
  opener = {
    open = [
      {
        run = "app2unit-open \"$1\"";
        desc = "Open";
        for = "linux";
      }
    ];
  };
  log = {
    enabled = true;
  };

  mgr = {
    ratio = [
      1
      4
      3
    ];
    show_hidden = true;
    show_symlink = true;
    sort_reverse = false;
    sort_sensitive = true;
    sort_dir_first = true;
    sort_by = "natural";
    linemode = "size_and_mtime";
  };

  preview = {
    image_filter = "lanczos3";
    image_quality = 90;
    tab_size = 1;
    max_width = 600;
    max_height = 900;
    cache_dir = "";
    ueberzug_scale = 1;
    ueberzug_offset = [
      0
      0
      0
      0
    ];
  };

  tasks = {
    micro_workers = 5;
    macro_workers = 10;
    bizarre_retry = 5;
  };

  plugin = {
    prepend_fetchers = [
      {
        id = "git";
        name = "*";
        run = "git";
      }
      {
        id = "git";
        name = "*/";
        run = "git";
      }
    ];

    prepend_preloaders = [
      {
        mime = "{audio,video,image}/*";
        run = "mediainfo";
      }
      {
        mime = "application/subrip";
        run = "mediainfo";
      }
    ];

    prepend_previewers = [
      {
        mime = "{audio,video,image}/*";
        run = "mediainfo";
      }

      {
        mime = "application/subrip";
        run = "mediainfo";
      }

      {
        name = "*/";
        run = "eza-preview";
      }

      {
        name = "*.csv";
        run = "rich-preview";
      }
      {
        name = "*.md";
        run = "rich-preview";
      }
      {
        name = "*.rst";
        run = "rich-preview";
      }
      {
        name = "*.ipynb";
        run = "rich-preview";
      }
      {
        name = "*.json";
        run = "rich-preview";
      }
    ];
  };

}
