{ self, ... }:
let
  inherit (self) themeNoHash;
in
{
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
        main.font = "monospace:size=11.5";
        mouse.hide-when-typing = true;
        desktop-notifications.command = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}";

        colors = with themeNoHash; {
          alpha = 0.9;
          foreground = "${base07}";
          background = "${base00}";
          regular0 = "${base00}"; # black
          regular1 = "${base08}"; # red
          regular2 = "${base0B}"; # green
          regular3 = "${base0A}"; # yellow
          regular4 = "${base0D}"; # blue
          regular5 = "${base0D}"; # magenta
          regular6 = "${base0C}"; # cyan
          regular7 = "${base07}"; # white
          bright0 = "${base03}"; # bright black
          bright1 = "${base08}"; # bright red
          bright2 = "${base0B}"; # bright green
          bright3 = "${base0A}"; # bright yellow
          bright4 = "${base0D}"; # bright blue
          bright5 = "${base0D}"; # bright magenta
          bright6 = "${base0C}"; # bright cyan
          bright7 = "${base07}"; # bright white
          "16" = "${base09}";
          "17" = "${base0F}";
          "18" = "${base01}";
          "19" = "${base02}";
          "20" = "${base04}";
          "21" = "${base06}";
        };
      };
    };
}
