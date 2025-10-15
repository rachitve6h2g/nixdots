{
  # qmlls will not be able to pick up qml modules that are not in QML2_IMPORT_PATH.
  # The easiest way to ensure this is by setting qt.enable to true
  # and installing the quickshell package globally.
  qt.enable = true;

  programs.quickshell = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };
}
