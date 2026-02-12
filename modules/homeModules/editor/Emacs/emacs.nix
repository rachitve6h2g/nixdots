{
  flake.homeModules.emacs =
    { pkgs, config, ... }:
    {
      stylix.targets.emacs = {
        opacity.override = rec {
          applications = 0.90;
          desktop = applications;
        };

        fonts.override = {
          applications = 11;
        };
      };

      home.packages = with pkgs; [
        bash-language-server # bash-language server
        ffmpegthumbnailer # For org-beautify links
        imagemagick # For rendering images inside org
        nixd # nix server
        nixfmt # for formatting nix
        poppler # For pdf reading
        shfmt # for formatting bash

        # Emacsclient needs to be restarted after every rebuild
        (pkgs.writeShellScriptBin "remacs" ''
          systemctl --user restart emacs                      
        '')

        # Alias for emacsclient
        (pkgs.writeShellScriptBin "ec" ''
          ${config.programs.emacs.package}/bin/emacsclient -a \"\" -c $@
        '')
      ];

      programs = {
        bash = {
          shellAliases = {
            ec = ''emacsclient -a "" -c'';
            epkgs = "nix-env -f '<nixpkgs>' -qaP -A emacsPackages";
          };
        };

        emacs = {
          enable = true;
          package = pkgs.emacs-pgtk;
          extraConfig = "(setq standard-indent 2)";
          extraPackages =
            epkgs: with epkgs; [
              ace-window # Better window navigation
              aria2 # See all the download processes and aria2 processes
              babel # Babel languages setup
              cape # Provides Completion At Point Extensions
              consult # Set up minibuffer actions and
              consult-dir # Really good package to traverse long distance directories using minibuffer
              consult-lsp # Lsp actions like diagnostics, finding symbols and other stuff
              consult-notes # For managing notes
              consult-org-roam
              consult-projectile # Needed for consult-project-switch, I guess(?)
              consult-todo
              corfu # Completion UI
              dash # It's a library that's needed by emacs for a lot of things
              dashboard
              diff-hl
              doom-modeline
              emacs
              embark
              embark-consult
              embark-org-roam
              emms
              eshell-git-prompt
              eshell-vterm
              forge
              json-mode
              ligature
              lsp-mode
              magit
              marginalia
              markdown-mode
              multiple-cursors
              nerd-icons
              nerd-icons-completion
              nerd-icons-corfu
              nerd-icons-dired
              nerd-icons-grep
              nerd-icons-ibuffer
              nerd-icons-xref
              nixfmt # https://github.com/purcell/emacs-nixfmt for editing nix
              nix-mode
              no-littering
              olivetti
              orderless
              org
              org-auto-tangle
              org-dashboard
              org-journal
              org-journal-list
              org-journal-tags
              org-modern

              (callPackage ./packages/_org-modern-indent.nix {
                inherit (pkgs) fetchFromGitHub;
                inherit (epkgs) melpaBuild;
              })

              org-roam
              org-roam-ui
              page-break-lines
              pdf-tools # For opening pdf's inside of emacs
              projectile
              projectile-ripgrep
              pulsar
              rainbow-delimiters
              ripgrep
              saveplace-pdf-view # To save the last visited information in pdf-mode
              shfmt
              tab-line-nerd-icons
              use-package
              vertico
              vterm
              which-key
              with-editor
              with-emacs
            ];

        };
      };

      services = {
        emacs = {
          enable = true;
          defaultEditor = true;
          socketActivation.enable = true;

          client = {
            enable = true;
            arguments = [
              "-a"
              "\"\""
              "-c"
            ];
          };
        };
      };
    };
}
