{
  programs = {
    kitty = {
      enable = true;
      shellIntegration.mode = "enabled";
      settings = {
        dynamic_background_opacity = true;
        enable_audio_bell = "no";
        cursor_trail = 3;
        cursor_trail_decay = "0.1 0.4";
      };
    };
  };

  stylix = {
    fonts.sizes.terminal = 14;
  };
}
