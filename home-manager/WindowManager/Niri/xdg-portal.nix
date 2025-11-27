{ pkgs, ... }:
{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-termfilechooser
      ];
      config.common = {
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
    };

    # The configuration file for xdg-desktop-portal-term-filechooser
    configFile = {
      "xdg-desktop-portal-termfilechooser/config" = {
        # source = "${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/config";
        text = /* ini */ ''
          [filechooser]
          cmd=yazi-wrapper.sh
          default_dir=$HOME
          ; Uncomment to skip creating destination save files with instructions in them
          ; create_help_file=0
          ; Uncomment and edit the line below to change the terminal emulator command
          ; env=TERMCMD=foot

          ; Mode must be one of 'suggested', 'default', or 'last'.
          open_mode=suggested
          save_mode=last

          env=kitty -T "terminal filechooser"
        '';
      };
      "xdg-desktop-portal-termfilechooser/yazi-wrapper.sh".source =
        "${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh";
    };
  };
}
