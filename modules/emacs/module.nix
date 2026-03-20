{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      # Wrap emacs packages and runtime binaries together
      emacsWrapped = inputs.wrappers.lib.wrapPackage (
        { ... }:
        {
          inherit pkgs;

          # Just provide the emacsPackages with the emacs-pgtk package
          package = import ./_packages/emacsPackages.nix { inherit pkgs; };

          # Extra runtime binaries go here
          extraPackages = import ./_packages/extraBinaries.nix { inherit pkgs; };
        }
      );

      # Extra stuff to bundle
      extraBundlePackages = [
        # Use `emacseditor` as $EDITOR and $VISUAL
        (pkgs.writeShellScriptBin "emacseditor" ''
          if [ -z "$1" ]; then
            exec ${emacsWrapped}/bin/emacsclient --create-frame --alternate-editor ${emacsWrapped}/bin/emacs
          else
            exec ${emacsWrapped}/bin/emacsclient --create-frame --alternate-editor ${emacsWrapped}/bin/emacs "$@"
          fi
        '')

        # Emacsclient needs to be restarted after every rebuild
        (pkgs.writeShellScriptBin "remacs" ''
          systemctl --user restart emacs
        '')

        # Alias for emacsclient
        (pkgs.writeShellScriptBin "ec" ''
          ${emacsWrapped}/bin/emacsclient -a \"\" -c $@
        '')

        (pkgs.writeShellScriptBin "epkgs" ''
          nix-env -f '<nixpkgs>' -qaP -A emacsPackages
        '')
      ];
    in
    {
      packages.emacsBundle = pkgs.symlinkJoin {
        name = "emacsBundle";
        paths = [
          emacsWrapped
          extraBundlePackages
        ];
      };
    };
}
