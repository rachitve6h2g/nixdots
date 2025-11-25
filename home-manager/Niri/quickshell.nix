{
  programs.quickshell = {
    enable = true;

    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
  };
}
