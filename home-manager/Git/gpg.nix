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
      enableScDaemon = true;
      enableSshSupport = true;

      pinentry = {
        package = pkgs.pinentry-curses;
        program = "pinentry-curses";
      };
    };
  };
}
