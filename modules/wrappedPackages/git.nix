{
  flake.wrappers.git =
    {
      wlib,
      lib,
      pkgs,
      ...
    }:
    let
      commitMsgHook = pkgs.writeShellScript "commit-msg" ''
        ${lib.getExe pkgs.gitlint} --msg-filename "$1"
      '';
      gitHooks = pkgs.runCommand "git-hooks" { } ''
        mkdir -p $out
        ln -s ${commitMsgHook} $out/commit-msg
      '';
      gitIgnores = [
        "*.bak"
        "*~"
        "*.tmp"
        ".direnv"
      ];

      globalIgnoreFiles = pkgs.writeText "global-gitignore" (lib.concatStringsSep "\n" gitIgnores + "\n");
    in
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
        core.hooksPath = gitHooks;
        core.excludesFile = globalIgnoreFiles;
      };

      env = rec {
        GIT_AUTHOR_NAME = "rachitvrma";
        GIT_AUTHOR_EMAIL = "rachitve6h2g@users.noreply.github.com";
        GIT_COMMITTER_NAME = GIT_AUTHOR_NAME;
        GIT_COMMITTER_EMAIL = GIT_AUTHOR_EMAIL;
        # GIT_CONFIG_GLOBAL = "";
      };
    };
}
