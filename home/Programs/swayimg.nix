{
  programs.swayimg = {
    enable = true;
    settings = {
      viewer = {
        # window = "#10000010";
        scale = "fill";
      };
      "info.viewer" = {
        top_left = "+name,+format";
      };
      "keys.viewer" = {
        "Shift+r" = "rand_file";
      };
    };
  };
}
