{
  flake.homeModules.desktop =
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
