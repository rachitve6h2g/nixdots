{
  services.walker = {
    enable = true;
    systemd.enable = true;

    settings = {
      click_to_close = true;
      page_jump_items = 10;
      hide_quick_activation = false;
      placeholders = {
        default = {
          input = "Search";
          list = "No Results";
        };
      };
      close_when_open = true;
      selection_wrap = false;
      disable_mouse = false;
      debug = false;
      keybinds = {
        toggle_exact = [
          "ctrl e"
        ];
        resume_last_query = [
          "ctrl r"
        ];
        quick_activate = [
          "F1"
          "F2"
          "F3"
          "F4"
        ];
        page_down = [
          "Page_Down"
        ];
        page_up = [
          "Page_Up"
        ];
        close = [
          "Escape"
        ];
        next = [
          "Down"
        ];
        previous = [
          "Up"
        ];
      };
      providers = {
        sets = {

        };
        max_results_provider = {

        };
        prefixes = [
          {
            prefix = ";";
            provider = "providerlist";
          }
          {
            prefix = ">";
            provider = "runner";
          }
          {
            provider = "files";
            prefix = "/";
          }
          {
            prefix = ".";
            provider = "symbols";
          }
          {
            prefix = "!";
            provider = "todo";
          }
          {
            provider = "calc";
            prefix = "=";
          }
          {
            prefix = "@";
            provider = "websearch";
          }
          {
            prefix = ":";
            provider = "clipboard";
          }
          {
            prefix = "$";
            provider = "windows";
          }
        ];
        clipboard = {
          time_format = "%d.%m. - %H:%M";
        };
        actions = {
          symbols = [
            {
              action = "run_cmd";
              label = "select";
              default = true;
              bind = "Return";
            }
          ];
          runner = [
            {
              action = "run";
              default = true;
              bind = "Return";
            }
            {
              action = "runterminal";
              label = "run in terminal";
              bind = "shift Return";
            }
          ];
          providerlist = [
            {
              after = "ClearReload";
              action = "activate";
              default = true;
              bind = "Return";
            }
          ];
          calc = [
            {
              action = "copy";
              default = true;
              bind = "Return";
            }
            {
              bind = "ctrl d";
              after = "AsyncReload";
              action = "delete";
            }
            {
              bind = "ctrl s";
              after = "AsyncClearReload";
              action = "save";
            }
          ];
          clipboard = [
            {
              bind = "Return";
              action = "copy";
              default = true;
            }
            {
              action = "remove";
              bind = "ctrl d";
              after = "AsyncClearReload";
            }
            {
              bind = "ctrl shift d";
              after = "AsyncClearReload";
              action = "remove_all";
              global = true;
              label = "clear";
            }
            {
              action = "toggle_images";
              global = true;
              label = "toggle images";
              bind = "ctrl i";
              after = "AsyncClearReload";
            }
            {
              action = "edit";
              bind = "ctrl o";
            }
          ];
          bluetooth = [
            {
              global = true;
              bind = "ctrl f";
              after = "AsyncClearReload";
              action = "find";
            }
            {
              action = "trust";
              bind = "ctrl t";
              after = "AsyncReload";
            }
            {
              after = "AsyncReload";
              action = "untrust";
              bind = "ctrl t";
            }
            {
              action = "pair";
              bind = "Return";
              after = "AsyncReload";
            }
            {
              action = "remove";
              bind = "ctrl d";
              after = "AsyncReload";
            }
            {
              after = "AsyncReload";
              action = "connect";
              bind = "Return";
            }
            {
              action = "disconnect";
              bind = "Return";
              after = "AsyncReload";
            }
          ];
          archlinuxpkgs = [
            {
              action = "install";
              bind = "Return";
              default = true;
            }
            {
              action = "remove";
              bind = "Return";
            }
          ];
          websearch = [
            {
              action = "search";
              default = true;
              bind = "Return";
            }
          ];
          files = [
            {
              action = "open";
              default = true;
              bind = "Return";
            }
            {
              action = "opendir";
              label = "open dir";
              bind = "ctrl Return";
            }
            {
              action = "copypath";
              label = "copy path";
              bind = "ctrl shift c";
            }
            {
              label = "copy file";
              bind = "ctrl c";
              action = "copyfile";
            }
          ];
          unicode = [
            {
              label = "select";
              default = true;
              bind = "Return";
              action = "run_cmd";
            }
          ];
          nirisessions = [
            {
              action = "start";
              label = "start";
              default = true;
              bind = "Return";
            }
            {
              bind = "ctrl Return";
              action = "start_new";
              label = "start blank";
            }
          ];
          fallback = [
            {
              action = "menus:open";
              label = "open";
              after = "Nothing";
            }
            {
              action = "menus:default";
              label = "run";
              after = "Close";
            }
            {
              action = "erase_history";
              label = "clear hist";
              bind = "ctrl h";
              after = "AsyncReload";
            }
          ];
          dmenu = [
            {
              bind = "Return";
              action = "select";
              default = true;
            }
          ];
          desktopapplications = [
            {
              action = "start";
              default = true;
              bind = "Return";
            }
            {
              action = "start:keep";
              label = "open+next";
              bind = "shift Return";
              after = "KeepOpen";
            }
            {
              label = "new instance";
              bind = "ctrl Return";
              action = "new_instance";
            }
            {
              action = "new_instance:keep";
              label = "new+next";
              bind = "ctrl alt Return";
              after = "KeepOpen";
            }
            {
              action = "pin";
              bind = "ctrl p";
              after = "AsyncReload";
            }
            {
              action = "unpin";
              bind = "ctrl p";
              after = "AsyncReload";
            }
            {
              action = "pinup";
              bind = "ctrl n";
              after = "AsyncReload";
            }
            {
              action = "pindown";
              bind = "ctrl m";
              after = "AsyncReload";
            }
          ];
          todo = [
            {
              action = "save";
              default = true;
              bind = "Return";
              after = "ClearReload";
            }
            {
              action = "delete";
              bind = "ctrl d";
              after = "ClearReload";
            }
            {
              action = "active";
              bind = "Return";
              after = "ClearReload";
            }
            {
              action = "inactive";
              bind = "Return";
              after = "ClearReload";
            }
            {
              action = "done";
              bind = "ctrl f";
              after = "ClearReload";
            }
            {
              action = "change_category";
              bind = "ctrl y";
              label = "change category";
              after = "AsyncClearReload";
            }
            {
              after = "ClearReload";
              global = true;
              action = "clear";
              bind = "ctrl x";
            }
          ];
        };
        default = [
          "desktopapplications"
          "calc"
          "runner"
          "websearch"
        ];
        empty = [
          "desktopapplications"
        ];
        ignore_preview = [

        ];
        max_results = 50;
        argument_delimiter = {
          runner = " ";
        };
      };
      theme = "default";
      shell = {
        anchor_top = true;
        anchor_bottom = true;
        anchor_left = true;
        anchor_right = true;
      };
      force_keyboard_focus = false;
      global_argument_delimiter = "#";
      exact_search_prefix = "'";
    };
  };
}
