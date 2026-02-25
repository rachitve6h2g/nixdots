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
      lib,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.foot ];

      filesToPatch = lib.mkAfter [
        "share/systemd/user/*.socket"
        "share/systemd/user/*.service"
      ];

      settings = {
        mouse.hide-when-typing = true;
        desktop-notifications.command = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}";

        colors = {
          alpha = 0.9;
          foreground = "ddc7a1";
          background = "202020";
          regular0 = "202020"; # black
          regular1 = "ea6962"; # red
          regular2 = "a9b665"; # green
          regular3 = "d8a657"; # yellow
          regular4 = "7daea3"; # blue
          regular5 = "d3869b"; # magenta
          regular6 = "89b482"; # cyan
          regular7 = "ddc7a1"; # white
          bright0 = "5a524c"; # bright black
          bright1 = "ea6962"; # bright red
          bright2 = "a9b665"; # bright green
          bright3 = "d8a657"; # bright yellow
          bright4 = "7daea3"; # bright blue
          bright5 = "d3869b"; # bright magenta
          bright6 = "89b482"; # bright cyan
          bright7 = "fbf1c7"; # bright whitee
          "16" = "e78a4e";
          "17" = "bd6f3e";
          "18" = "2a2827";
          "19" = "504945";
          "20" = "bdae93";
          "21" = "ebdbb2";
        };
      };
    };
}
