{
  networking = {
    # Refer this https://mynixos.com/nixpkgs/option/networking.hostName
    # For properly setting your hostname
    hostName = "hppavilion"; # Define your
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
          # General = {
          #   EnableNetworkConfiguration = true;
          # };
          # IPv4 = {
          #   SendHostname = true;
          # };
        };
      };
    };
  };

  users.users.krish.extraGroups = [ "networkmanager" ];
}
