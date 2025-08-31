{
  programs = {
    kitty = {
      enable = true;

      # TODO: Set the theme and integration of shell

      shellIntegration.mode = "enabled";

      settings = {
        dynamic_background_opacity = true;
        notify_on_cmd_finish = "unfocused 5.0 command notify-send --icon=kitty \"job finished with status: %s %c\"";
        enable_audio_bell = "no";
        cursor_trail = 3;
        cursor_trail_decay = "0.1 0.4";
      };
    };
  };
  stylix = {
    fonts.sizes.terminal = 14;
    # opacity.terminal = 0.9;
  };
}
