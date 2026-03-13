{ inputs, ... }:
{
  flake.nixosModules.extra_hjem =
    {
      pkgs,
      # lib,
      ...
    }:
    {
      imports = [ inputs.hjem.nixosModules.default ];
      hjem = {
        clobberByDefault = true;
        users = {
          krish = {
            user = "krish";
            directory = "/home/krish";
            files = {
              ".face" = {
                source = (
                  pkgs.fetchurl {
                    url = "https://raw.githubusercontent.com/rachitvrma/Wallpapers/main/Shinchan.png";
                    hash = "sha256-CP9uGyslZ19wCaglMb1UG+NmcU/GxN5HDXSdrO5jAlw=";
                  }
                );
              };
            };
          };
        };
      };
    };
}
