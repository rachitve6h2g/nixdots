{ pkgs, ... }:
{
  home.packages = with pkgs; [ nixfmt ];
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
        use-package # for declratively setting up packages
        vterm # for terminal inside emacs
        format-all # formatter for text files
      ];
    extraConfig =
      # lisp
      ''
        (setq standard-indent 2)
      '';
  };
}
