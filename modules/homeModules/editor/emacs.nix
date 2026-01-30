{
  flake.homeModules.emacs =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      stylix.targets.emacs.enable = false;

      home = {
        packages = with pkgs; [
          nixfmt
          nixd

          mupdf # for doc viewer
          ghostscript # for doc viewer as well

          # For dirvish previews
          ffmpegthumbnailer
          mediainfo
          poppler-utils
          imagemagick
          vips
          epub-thumbnailer

          shfmt # for formatting shell scripts

          # for c dev environment
          bear
          clang-tools

          # For qml
          kdePackages.qtdeclarative # contains the qmlls server
        ];

        shellAliases = {
          epkgs = "nix-env -f '<nixpkgs>' -qaP -A emacsPackages";
          ec = "emacsclient -a \"\" -c";
        };
      };

      programs.bash.shellAliases = lib.mkAfter config.home.shellAliases;

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
            cape # completion provider
            catppuccin-theme # I know right?
            command-log-mode # Not necessary but okay
            consult # Perform very useful actions like find and ripgrep, etc
            corfu # completion ui
            dashboard # A good startup is a good thing
            diff-hl # get git diff info in dired
            doom-modeline # Cleaner, better modeline
            # doom-themes # Set nord from doom themes
            emacs # Apparently there's a emacs package inside emacs
            embark # Perform actions from the minibuffer
            embark-consult # embark integration with consult
            exec-path-from-shell # take $PATH from non-emacs default shell
            forge # Project management
            ligature # For rendering ligatures rightly
            lsp-mode # name says it
            magit # It's magit
            marginalia # Goes with orderless, cape, consult, vertico
            nerd-icons # Better than all-the-icons
            nerd-icons-completion # Name says it
            nerd-icons-dired # For dired
            nerd-icons-ibuffer # for ibuffer
            nixfmt # For formatting nix code
            nix-mode # nix major mode, not built-in in emacs
            orderless # completion
            org # Not going to live without this!
            org-auto-tangle # auto-tangle org files
            org-bullets # For the bullets
            org-ql
            pdf-tools # For viewing pdfs inside of emacs
            pretty-sha-path # Useful for guix/nix users
            pulsar
            projectile # Project completion
            rainbow-delimiters # Better parentheses
            saveplace-pdf-view # Save the place where you last visited pdf, goes with pdf-tools

            (treesit-grammars.with-grammars (
              grammars: with grammars; [
                tree-sitter-bash
                tree-sitter-nix
              ]
            ))

            vertico # Goes with orderless, cape, consult, marginalia
            visual-fill-column # center org files
            which-key # Better key combo UI
            xclip # For clipbard
          ];

        extraConfig =
          # lisp
          ''
            (setq standard-indent 2)
          '';

      };
    };
}
