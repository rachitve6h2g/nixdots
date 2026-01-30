{
  flake.homeModules.shell =
    { pkgs, ... }:
    {
      programs = {
        bat = {
          enable = true;

          config = {
            pager = "less -FR";
          };

          extraPackages = with pkgs.bat-extras; [
            batdiff
            batman
            prettybat
          ];
        };
        # Set MANPAGER to batman
        bash.bashrcExtra = ''
          eval "$(${pkgs.bat-extras.batman}/bin/batman --export-env)"
        '';
      };
    };
}
