{
  flake.homeModules.vscode =
    { pkgs, lib, ... }:
    {
      programs = {
        gcc.enable = true;
        vscode = {
          enable = true;
          profiles.default = {
            extensions = with pkgs.vscode-extensions; [
              vscodevim.vim
              yzhang.markdown-all-in-one
              formulahendry.code-runner
              ms-vscode.cpptools
              ms-vscode.cpptools-extension-pack
              jnoortheen.nix-ide
              mkhl.direnv
            ];
            userSettings = lib.mkAfter {
              "git.openRepositoryInParentFolders" = "always";
            };
          };
        };
      };
    };
}
