{ globalValues, ... }:
{
  services = {
    openssh = {
      enable = true;
      authorizedKeysInHomedir = true; # Keep authorized keys in home_directory
      ports = [
        5432
        22
      ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "${globalValues.username}" ];
      };
    };

    tailscale.enable = true;

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
