{
  flake.wrappers.neovim =
    { wlib, ... }:
    {
      imports = [ wlib.wrapperModules.neovim ];
    };
}
