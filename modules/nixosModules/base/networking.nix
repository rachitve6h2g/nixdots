{
  flake.nixosModules.networking = {
    networking = {
      # useNetworkd = true;
      networkmanager = {
        wifi = {
          backend = "iwd";
        };
      };
      wireless = {
        iwd = {
          enable = true;
          settings = {
            Network = {
              EnableIPv6 = true;
            };
            Settings = {
              AutoConnect = true;
            };
          };
        };
      };

      nftables.enable = true;
      firewall = {
        enable = true;
        allowedTCPPorts = [
          80
          443
        ];
        allowedUDPPortRanges = [
          {
            from = 4000;
            to = 4007;
          }
          {
            from = 8000;
            to = 8010;
          }
        ];
      };
    };

  };
}
