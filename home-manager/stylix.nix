{ osConfig, ... }:
{
  stylix = {
    enable = true;
    # If set in the configuration.nix then it cannot be set here if using
    # home-manager as nixos module.
    base16Scheme = osConfig.stylix.base16Scheme;
    polarity = osConfig.stylix.polarity;
    enableReleaseChecks = true;

    # fonts = osConfig.stylix.fonts;
  };
}
