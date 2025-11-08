{
  programs = {
    cmus = {
      enable = true;
    };
  };

  xdg.configFile = {
    "cmus/kanagawa.theme".text = /* ini */ ''
      # COLORS
      #
      # fg: 187
      # bg: 234
      #
      # red: 131
      # green: 065
      # yellow: 180
      # blue: 111
      # magenta: 103
      # cyan: 066
      #
      # black: 232
      # white: 144
      #
      # select-fg: 144
      # select-bg: 024

      ### colors
      ### {{{

      # where you type your commands
      set color_cmdline_fg=187
      set color_cmdline_bg=default

      # the vertical line on the main window
      set color_separator=232

      # this displays how much time there is left from the song
      set color_statusline_bg=default
      set color_statusline_fg=103

      # the songs title is displayed here
      set color_titleline_bg=234
      set color_titleline_fg=180

      # the colors of the main window
      set color_win_bg=default
      set color_win_fg=111

      # color of the active entries when not selected
      set color_win_cur=180

      # maybe sets the colors of a different layout?
      set color_win_dir=180

      # color of the inactive songnames
      set color_win_fg=187

      ### ---- settings for the INACTIVE window ---- ###

      # the played entries colors when selected
      set color_win_inactive_cur_sel_bg=234
      set color_win_inactive_cur_sel_fg=111

      # the inactive entries colors when selected
      set color_win_inactive_sel_bg=234
      set color_win_inactive_sel_fg=066

      ### ---- settings for the ACTIVE window ---- ###

      # the played entries color when selected
      set color_win_cur_sel_bg=234
      set color_win_cur_sel_fg=180

      #  the inactive entries color when selected
      set color_win_sel_bg=234
      set color_win_sel_fg=111

      # --- END -- #

      # these set the colors of the titlebar at the top of the window
      set color_win_title_bg=234
      set color_win_title_fg=180

      # textcolor in commandbar (error(red) and info(green))
      set color_error=131
      set color_info=187

      ### }}}
    '';

    "cmus/catppuccin.theme".text = /* ini */ ''
      ### 'Catppuccin' theme for CMus (for 255 color terms)
      set color_cmdline_bg=default
      # Text Color White
      set color_cmdline_fg=254
      # Error Color Red
      set color_error=211
      # Info Color Yellow
      set color_info=223
      # Separator Color Blue
      set color_separator=117

      # Statusline background Black
      set color_statusline_bg=default
      #Statusline foreground #White
      set color_statusline_fg=254

      # Titleline background Green
      set color_titleline_bg=151
      # Titleline foreground Black
      set color_titleline_fg=16

      # Terminal default as background
      set color_win_bg=default

      # Currently Playing song Blue 
      set color_win_cur=117
      # Indicator over currently playing song Green
      set color_win_cur_sel_bg=151
      set color_win_cur_sel_fg=16

      # Browser Directory Colors White
      set color_win_dir=254

      # Playlist browser general text color White
      set color_win_fg=254
      # Selected inactive Directory of currently playing Album/Song Maroon bg Black fg 
      set color_win_inactive_cur_sel_bg=181
      set color_win_inactive_cur_sel_fg=235

      # Selected inactive Directory Teal bg Black fg 
      set color_win_inactive_sel_bg=152
      set color_win_inactive_sel_fg=235

      # Indicator color Blue
      set color_win_sel_bg=117
      set color_win_sel_fg=235

      # Artist/Album / Track Headings No background Blue text
      set color_win_title_bg=default
      set color_win_title_fg=117
    '';
  };
}
