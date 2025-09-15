{
  programs = {
    niriswitcher = {
      enable = true;
      settings = {
        keys = {
          switch = {
            prev = "Shift+Tab";
            next = "Tab";
          };
          window = {
            close = "q";
            abort = "Escape";
          };
          workspace = {
            next = "grave";
            prev = "Shift+asciitilde";
          };
          modifier = "Alt_L";
        };
        separate_workspaces = true;
        current_output_only = false;
        center_on_focus = false;
        appearance = {
          max_width = 800;
          min_width = 600;
          system_theme = "dark";
          workspace_format = "{output}-{idx}";
          animation = {
            reveal = {
              hide_duration = 200;
              show_duration = 200;
              easing = "ease-out-cubic";
            };
            resize = {
              duration = 200;
              easing = "ease-in-out-cubic";
            };
            workspace = {
              duration = 200;
              transition = "slide";
            };
            switch = {
              duration = 200;
              easing = "ease-out-cubic";
            };
          };
          icon_size = 128;
        };
        double_click_to_hide = false;
        log_level = "WARN";
        workspace = {
          mru_sort_in_workspace = false;
          mru_sort_across_workspace = true;
        };
      };

    };
  };
}
