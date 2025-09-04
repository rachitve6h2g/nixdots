{
  services = {
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "never";

      settings = {
        programs_options = {
          udisks_version = 2;
          tray = false;
        };
        icon_names.media = [ "media-optical" ];
      };
    };
  };
}
