{ pkgs, ... }:
{
  services.emacs = {
    enable = true;
    socketActivation.enable = true;
    defaultEditor = true;
    # Uses programs.emacs.package by default.
    # package = pkgs.emacs-pgtk;

    client = {
      enable = true;
      arguments = [
        "-c"
      ];
    };

  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages =
      epkgs: with epkgs; [
        magit
        nix-mode
        nix-ts-mode
        (treesit-grammars.with-grammars (
          grammars: with grammars; [
            tree-sitter-bash
            tree-sitter-nix
          ]
        ))
      ];
    extraConfig =
      # lisp
      ''
        (setq standard-indent 2)
      '';
  };
}
