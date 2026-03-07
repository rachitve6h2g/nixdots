{
  flake.wrappers.aria2 =
    {
      wlib,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.aria2 ];

      settings = {
        continue = true;
        dir = "/home/krish/Downloads";
        input-file = "/home/krish/Downloads/.aria_downloads.conf";
        file-allocation = "none";
        log-level = "warn";
        max-connection-per-server = 4;
        min-split-size = "5M";
        on-download-complete = "exit";
        auto-file-renaming = false;
      };
    };
}
