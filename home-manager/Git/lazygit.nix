{ lib, ... }:
{
  programs = {
    lazygit = {
      enable = true;
      settings = {
        gui = {
          nerdFontsVersion = 3;
        };

        git = {
          paging = {
            colorArg = "always";
            pager = lib.concatStringsSep " " [
              "delta"
              "--dark"
              "--paging=never"
              "--line-numbers"
              "--hyperlinks"
              "--hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\""
            ];
          };
        };
      };
    };
  };
}
