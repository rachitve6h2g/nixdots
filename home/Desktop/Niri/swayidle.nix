{
  pkgs,
  ...
}:
{
  services = {
    swayidle =
      let
        lock = "${pkgs.swaylock-effects}/bin/swaylock";
        display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
      in
      {
        enable = true;
        package = pkgs.swayidle;

        events = [
          {
            event = "before-sleep";
            command = (display "off") + ";" + lock;
          }
          {
            event = "after-resume";
            command = display "on";
          }
          {
            event = "lock";
            command = (display "off") + ";" + lock;
          }
          {
            event = "unlock";
            command = display "on";
          }
        ];

        timeouts = [
          {
            timeout = 15;
            command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
          }

          {
            timeout = 20;
            command = lock;
          }

          {
            timeout = 25;
            command = display "off";
            resumeCommand = display "on";
          }

          {
            timeout = 30;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
      };
  };
}
