{ osConfig, ... }:
{
  stylix = {
    enable = true;
    # If set in the configuration.nix then it cannot be set here if using
    # home-manager as nixos module.
    base16Scheme = osConfig.stylix.base16Scheme; # This has to be set despite
    polarity = osConfig.stylix.polarity; # configuration.nix, better osConfig sync.
    enableReleaseChecks = true;

    # If declared in configuration.nix, then not needed here
    # fonts = osConfig.stylix.fonts;
  };
}
