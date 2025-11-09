{
  networking = {
    useNetworkd = true;
    # Refer this https://mynixos.com/nixpkgs/option/networking.hostName
    # For properly setting your hostname
    hostName = "nixpavilion"; # Define your
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
}
