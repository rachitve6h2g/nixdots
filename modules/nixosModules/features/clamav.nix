{
  flake.nixosModules.clamav =
    { pkgs, lib, ... }:
    {
      services = {
        clamav = {
          daemon = {
            enable = true;
            settings =
              let
                virusEvent = pkgs.writeShellScriptBin "virus-event.bash" ''
                  PATH=${
                    lib.makeBinPath (
                      with pkgs;
                      [
                        libnotify
                        sudo
                        coreutils
                        bash
                      ]
                    )
                  }
                  ALERT="Signature detected by clamav: $CLAM_VIRUSEVENT_VIRUSNAME in $CLAM_VIRUSEVENT_FILENAME"

                  # Send an alert to all graphical users.
                  for ADDRESS in /run/user/*; do
                      USERID=''${ADDRESS#/run/user/}
                      ${pkgs.sudo}/bin/sudo -u "#$USERID" DBUS_SESSION_BUS_ADDRESS="unix:path=$ADDRESS/bus" PATH=''${PATH} \
                          ${pkgs.libnotify}/bin/notify-send -u critical -i dialog-warning "Virus found!" "$ALERT"
                  done
                '';
              in
              {
                LogTime = "yes";
                OnAccessPrevention = "no";
                OnAccessMountPath = "/";
                OnAccessIncludePath = "/home";
                OnAccessExtraScanning = "yes";
                ExtendedDetectionInfo = "yes";
                MaxDirectoryRecursion = 20;

                DetectPUA = "yes";
                HeuristicAlerts = "yes";
                ScanPE = "yes";
                ScanELF = "yes";
                ScanOLE2 = "yes";
                ScanPDF = "yes";
                ScanSWF = "yes";
                ScanXMLDOCS = "yes";
                ScanHWP3 = "yes";
                ScanOneNote = "yes";
                ScanMail = "yes";
                ScanHTML = "yes";
                ScanArchive = "yes";
                Bytecode = "yes";
                AlertBrokenExecutables = "yes";
                AlertBrokenMedia = "yes";
                AlertEncrypted = "yes";
                AlertEncryptedArchive = "yes";
                AlertEncryptedDoc = "yes";
                AlertOLE2Macros = "yes";
                AlertPartitionIntersection = "yes";

                VirusEvent = "${virusEvent}/bin/virus-event.sh";

                ConcurrentDatabaseReload = "no";
              };
          };
          updater.enable = true;
          scanner.enable = true;
          fangfrisch.enable = true;
        };
      };

      security.sudo.extraConfig = ''
        clamav ALL = (ALL) NOPASSWD: SETENV: ${pkgs.libnotify}/bin/notify-send
      '';
    };
}
