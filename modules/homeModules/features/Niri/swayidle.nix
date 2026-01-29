{
  flake.homeModules.niri =
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
            brightness = "${pkgs.brightnessctl}/bin/brightnessctl";
          in
          {
            enable = true;
            package = pkgs.swayidle;

            events = {
              before-sleep = (display "off") + ";" + lock;

              after-resume = display "on";

              lock = (display "off") + ";" + lock;

              unlock = display "on";
            };

            timeouts = [
              {
                timeout = 150;
                command = "${brightness} -s set 10";
                resumeCommand = "${brightness} -r";
              }

              {
                timeout = 300;
                command = lock;
              }

              {
                timeout = 330;
                command = display "off";
                resumeCommand = (display "on") + "&& ${brightness} -r";
              }

              {
                timeout = 1800;
                command = "${pkgs.systemd}/bin/systemctl suspend";
              }
            ];
          };
      };
    };
}
