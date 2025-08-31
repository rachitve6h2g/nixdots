{
  programs.gcc = {
    enable = true;
    colors = {
      error = "01;31";
      warning = "01:33";
      note = "01;36";
      caret = "01;34";
      locus = "00;32";
      quote = "00;35";
    };
  };
}
