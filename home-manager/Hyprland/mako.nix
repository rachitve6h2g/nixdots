{
  pkgs,
  config,
  ...
}:
{
  services.mako = {
    enable = true;

    settings = {
      anchor = "top-right";
      max-history = 10;
      layer = "overlay";
      markup = true;
      sort = "-time";

      icons = true;
      icon-path = "${config.stylix.iconTheme.package}/share/icons/${config.stylix.iconTheme.light}";

      actions = true;

      border-radius = 10;

      default-timeout = 5000;
      ignore-timeout = true;
      on-notify = "exec ${pkgs.mpv}/bin/mpv ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/message.oga";
      on-button-middle = "exec makoctl menu -n \"$id\" wofi -S dmenu -p 'Select Action: '";

      # Sections are written like this
      "mode=do-not-disturb" = {
        invisible = 1;
      };
    };
  };
}
