{
  flake.wrappers.neovim =
    { wlib, pkgs, ... }:
    {
      imports = [ wlib.wrapperModules.neovim ];

    };
}
