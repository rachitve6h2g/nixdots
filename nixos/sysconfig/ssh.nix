{
  services = {
    openssh = {
      enable = true;
      authorizedKeysInHomedir = true; # Keep authorized keys in home_directory
      ports = [ 5432 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "krish" ];
      };
    };

    # Enable fail2ban for banning multiple authentication attempts
    fail2ban = {
      enable = true;
    };

    endlessh = {
      enable = true;
      port = 8022;
      openFirewall = true;
    };
  };
}
