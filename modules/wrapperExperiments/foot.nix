{
  perSystem = {
    wrappers.control_type = "build";
    wrappers.packages = {
      foot = true;
    };
  };
  flake.wrappers.foot =
    {
      wlib,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.foot ];
      settings = {
        mouse.hide-when-typing = true;
        desktop-notifications.command = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
      };
    };
}
