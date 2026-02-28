{ ... }:
let
  theme = {
    # Gruvbox Material
    /*
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
    */

    # Kanagawa Dragon
    base00 = "#181616";
    base01 = "#282727";
    base02 = "#393836";
    base03 = "#625e5a";
    base04 = "#737c73";
    base05 = "#c5c9c5";
    base06 = "#c8c093";
    base07 = "#c5c9c5";
    base08 = "#c4746e";
    base09 = "#b6927b";
    base0A = "#c4b28a";
    base0B = "#8a9a7b";
    base0C = "#8ea4a2";
    base0D = "#8ba4b0";
    base0E = "#a292a3";
    base0F = "#b98d7b";

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
