{
  flake.wrappers.git =
    { wlib, ... }:
    {
      imports = [ wlib.wrapperModules.git ];
      # TODO: use hjem for managing $XDG_CONFIG_HOME/git/ignore
      # *~
      # #*#
      # .#*
      # *.swp

      settings = {
        remote = {
          pushDefault = "origin";
        };

        user = {
          name = "Rachit Kumar Verma";
          email = "rachitve6h2g@users.noreply.github.com";
        };
        alias = {
          co = "checkout";
          s = "status";
          ss = "status --short --branch";
          ci = "commit";
        };
      };

      env = rec {
        GIT_AUTHOR_NAME = "rachitvrma";
        GIT_AUTHOR_EMAIL = "rachitve6h2g@users.noreply.github.com";
        GIT_COMMITTER_NAME = GIT_AUTHOR_NAME;
        GIT_COMMITTER_EMAIL = GIT_AUTHOR_EMAIL;
      };
    };
}
