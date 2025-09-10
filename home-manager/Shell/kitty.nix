{
  programs = {
    kitty = {
      enable = true;
      shellIntegration.mode = "enabled";
      enableGitIntegration = true;
      settings = {
        dynamic_background_opacity = true;
        enable_audio_bell = "no";
        cursor_trail = 1;
        cursor_trail_decay = "0.1 0.4";
        window_margin_width = 21.75;
        shell = "bash";
        notify_on_cmd_finish = "unfocused 5.0 command notify-send --icon=kitty \"Job finished with status: %s %c\"";
      };
    };
  };

  stylix = {
    fonts.sizes.terminal = 14;
    opacity.terminal = 0.85;
  };
}
