{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";
    polarity = "dark";
    enableReleaseChecks = true;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.comic-shanns-mono;
        name = "ComicShannsMono Nerd Font";
      };
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
