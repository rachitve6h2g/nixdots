{
  programs = {
    quickshell = {
      enable = true;
      configs = { };
      activeConfig = null;
      systemd = {
        enable = true;
        target = "graphical-session.target";
      };
    };
  };
}
