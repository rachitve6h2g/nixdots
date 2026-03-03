# This module isn't working in my laptop
{
  flake.nixosModules.printing =
    { pkgs, ... }:
    {
      programs.system-config-printer.enable = true;
      services = {
        system-config-printer.enable = true;
        avahi = {
          # For hi-browse
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
        ipp-usb.enable = true; # Auto-discover usb printers
        printing = {
          enable = true;
          cups-pdf.enable = true;
          logLevel = "debug";
          drivers = with pkgs; [
            cups-filters
            cups-browsed
            hplip
            hplipWithPlugin
            gutenprint
          ];
        };
      };

      hardware.printers = {
        ensureDefaultPrinter = "HP_LaserJet_Professional_M1136_MFP";
        ensurePrinters = [
          {
            name = "HP_LaserJet_Professional_M1136_MFP";
            location = "Home";
            deviceUri = "usb://HP_LaserJet_Professional_M1136_MFP?serial=000000000QH97FCFPR1a";
            model = "hp-laserjet_professional_m1136_mfp.ppd.gz";
          }
        ];
      };
    };
}
