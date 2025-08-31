{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.wgetpaste ];

    file.".wgetpaste.d/main.conf" = {
      enable = true;
      source = ./main.conf;
    };
  };
}
