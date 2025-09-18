{
  # see home-manager config for kdeconnect
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  home-manager.users.krish.services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
