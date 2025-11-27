{
  wayland.windowManager.river = {
    enable = true;
    systemd.enable = true;
    extraConfig = ''${builtins.readFile ./init.sh}'';
  };

  xdg.configFile = {
    "wofi/leave/leave.sh" = {
      source = ./leave.sh;
      executable = true;
    };
  };
}
