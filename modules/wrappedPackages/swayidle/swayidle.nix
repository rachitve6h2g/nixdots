{ self, ... }:
{
  flake.wrappers.swayidle =
    {
      # wlib,
      pkgs,
      lib,
      ...
    }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
      lock = "${lib.getExe' selfpkgs.noctalia-shell "noctalia-shell"} ipc call lockScreen lock";
      # Niri
      display = status: "${selfpkgs.niri}/bin/niri msg action power-${status}-monitors";
    in
    {
      imports = [ self.wrapperModules.swayidle-module ];
      timeouts = [
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

      events = {
        before-sleep = (display "off") + "; " + lock;
        after-resume = display "on";
        lock = (display "off") + "; " + lock;
        unlock = display "on";
      };
    };
}
