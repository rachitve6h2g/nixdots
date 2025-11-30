{ pkgs, ... }:
{
  # home.packages = [ pkgs.gcr ]; # Only if using pinentry-gnome3
  programs = {
    gpg = {
      enable = true;
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableScDaemon = false; # only when using YubiKeys or hardware
      # verification method.
      enableSshSupport = true;

      defaultCacheTtl = 7200;
      maxCacheTtl = 86400;

      pinentry = {
        package = pkgs.pinentry-curses;
        program = "pinentry-curses";
      };
    };
  };
}
