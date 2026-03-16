{ inputs, self, ... }:
{
  perSystem =
    { pkgs, lib, ... }:
    let
      emacsWrappedPath = lib.getExe' emacsWrapped "emacsclient";
      # To be used as the $EDITOR variable
      # BUNDLE
      editorScript = pkgs.writeShellScriptBin "emacseditor" ''
        if [ -z "$1" ]; then
          exec ${emacsWrappedPath} --create-frame --alternate-editor ${emacsWrapped}/bin/emacs
        else
          exec ${emacsWrappedPath}/bin/emacsclient --alternate-editor ${emacsWrapped}/bin/emacs "$@"
        fi
      '';

      # Emacsclient needs to be started after every rebuild
      # BUNDLE
      restartEmacsClient = pkgs.writeShellScriptBin "remacs" ''
        systemctl --user restart emacs
      '';

      # Start emacsclient in the terminal by typing ec
      # BUNDLE
      emacsClientAlias = pkgs.writeShellScriptBin "ec" ''
        ${emacsWrappedPath} -a \"\" -c $@
      '';

      # List all the packages in Elpa/Melpa in the terminal
      # BUNDLE
      listEpkgs = pkgs.writeShellScriptBin "epkgs" ''
        nix-env -f '<nixpkgs>' -qaP -A services
      '';

      # BUNDLE
      emacsWrapped = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;

        # Extra Packages to be wrapped with emacs
        extraPackages = import ./_extraBinaries.nix { inherit pkgs self; };

        # Emacs packages in elpa, melpa and on GitHub
        package = import ./_emacsPkgs.nix { inherit pkgs; };
      };
    in
    {
      packages = {
        inherit emacsWrapped;
        emacsBundle = pkgs.symlinkJoin {
          name = "emacsBundle";
          paths = [
            emacsClientAlias
            emacsWrapped
            restartEmacsClient
            listEpkgs
            editorScript
          ];
        };
      };
    };
}
