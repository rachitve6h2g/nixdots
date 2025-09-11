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
    extraConfig =
      # lisp
      ''
        (setq standard-indent 2)
      '';
  };
}
