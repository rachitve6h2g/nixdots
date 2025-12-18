{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixfmt

    mupdf # for doc viewer
    ghostscript # for doc viewer as well
    # vlc # for listen.el
  ];

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
        "-a"
        "emacs"
      ];
    };

  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages =
      epkgs: with epkgs; [
        dirvish
        envrc # for working with direnv

        # Get a lighter thing, like mpv to work in emacs
        # listen # For listening music

        magit
        org # For mode
        nix-mode
        nix-ts-mode
        (treesit-grammars.with-grammars (
          grammars: with grammars; [
            tree-sitter-bash
            tree-sitter-nix
          ]
        ))
        use-package # for declratively setting up packages
        vterm # for terminal inside emacs
        format-all # formatter for text files

        pdf-tools # for pdf viewing
        pdf-view-restore # for restoring the last page of pdf visited

        ligature # for ligature support
        nerd-icons
        # Lsp setup
        lsp-mode
      ];

    extraConfig =
      # lisp
      ''
        (setq standard-indent 2)
      '';
  };
}
