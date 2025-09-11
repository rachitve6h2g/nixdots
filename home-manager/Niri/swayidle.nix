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
            timeout = 150;
            command = "brightnessctl -s set 10";
            resumeCommand = "brightnessctl -r";
          }

          {
            timeout = 300;
            command = lock;
          }

          {
            timeout = 330;
            command = display "off";
            resumeCommand = (display "on") + "&& brightnessctl -r";
          }

          {
            timeout = 1800;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
      };
  };
}
