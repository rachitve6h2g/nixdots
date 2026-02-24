{
  flake.homeModules.shell = {
    programs.foot = {
      enable = true;
      server.enable = true;

      settings = {
        mouse.hide-when-typing = true;
        desktop-notifications.command = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
      };
    };
  };
}
