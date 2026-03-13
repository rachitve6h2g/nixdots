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
          br = "branch";

          # Sync local main with upstream and update your fork (origin)
          sync = "!f() { git checkout main && git pull upstream main && git push origin main; }; f";
          # Update current branch by rebasing onto the remote to avoid merge bubbles
          up = "pull --rebase --autostash";
          # Quick stash including untracked files
          stsh = "stash push -u -m";
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
