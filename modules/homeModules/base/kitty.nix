{
  flake.homeModules.shell = {
    programs = {
      kitty = {
        enable = true;
        shellIntegration = {
          mode = "enabled";
          enableBashIntegration = true;
        };
        # enableGitIntegration = true; # Use difftastic instead.
        settings = {
          allow_remote_control = "yes";
          dynamic_background_opacity = true;
          enable_audio_bell = "no";
          cursor_trail = 1;
          cursor_trail_decay = "0.1 0.4";
          window_margin_width = 21;
          shell = "bash";
          notify_on_cmd_finish = "unfocused 5.0 command notify-send --icon=kitty \"Job finished with status: %s %c\"";
          background_blur = 32;

          # Tab style
          tab_bar_min_tabs = 1;
          tab_bar_edge = "bottom";
          tab_bar_style = "powerline";
          tab_powerline_style = "slanted";
          tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
        };

        quickAccessTerminalConfig = {
          lines = 25;
          columns = 80;
          edge = "none";
          hide_on_focus_loss = "no";
          background_opacity = 0.9;
        };

      };
    };
  };
}
