{
  flake.wrappers.termusic =
    {
      config,
      wlib,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [ wlib.modules.default ];
      options = { };
      config = { };
    };
}
