{ inputs, ... }:
{
  flake.nixosModules.stylix =
    {
      config,
      pkgs,
      ...
    }:
    {
      # NOTE: Please change stylix modules for user home-manager
      # configuration as well. It's not yet been centralized
      # TODO: Centralize some stylix modules for home-manager
      # and NixOS configuration.
      # See $PROJECT_ROOT/users/${username}/stylix.nix
      imports = [ inputs.stylix.nixosModules.stylix ];

      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

        # This is for managing fonts for programs
        # like kmscon. Otherwise, we would have to change
        # font names in 10 different places.
        fonts = {
          monospace = {
            package = pkgs.maple-mono.NF;
            name = "Maple Mono NF";
          };
          serif = config.stylix.fonts.monospace;
          sansSerif = config.stylix.fonts.monospace;
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
        };
      };
    };
}
