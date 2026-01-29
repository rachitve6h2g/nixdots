{
  flake.homeModules.fuzzel =
    { lib, pkgs, ... }:
    {
      programs.fuzzel = {
        enable = true;

        settings = lib.mkAfter {
          main = {
            terminal = "${pkgs.kitty}/bin/kitty";
          };
        };
      };
    };
}
