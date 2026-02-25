{ ... }:
let
  theme = {
    base00 = "#141617"; # bg
    base01 = "#2a2827"; # dark
    base02 = "#504945";
    base03 = "#5a524c";
    base04 = "#bdae93";
    base05 = "#ddc7a1";
    base06 = "#ebdbb2"; # fg
    base07 = "#fbf1c7"; # light fg
    base08 = "#ea6962"; # red
    base09 = "#e78a4e"; # orange
    base0A = "#d8a657"; # yellow
    base0B = "#a9b665"; # green
    base0C = "#89b482"; # cyan
    base0D = "#7daea3"; # blue
    base0E = "#d3869b"; # magenta
    base0F = "#bd6f3e"; # orange
  };

  stripHash =
    str:
    if builtins.substring 0 1 str == "#" then
      builtins.substring 1 (builtins.stringLength str - 1) str
    else
      str;

  themeNoHash = builtins.mapAttrs (_: v: stripHash v) theme;
in
{
  flake = {
    inherit theme themeNoHash;
  };
}
