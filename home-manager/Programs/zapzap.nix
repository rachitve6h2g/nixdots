{
  programs.zapzap = {
    enable = true;
    settings = {
      notifications.donation_message = true;
      system = {
        scale = 150;
        theme = "dark";
        wayland = true;
      };
      website = {
        open_page = false;
      };
    };
  };
}
