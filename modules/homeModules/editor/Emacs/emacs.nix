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
        imagemagick # For rendering images inside org
        bash-language-server # bash-language server
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
              ace-window
              babel
              cape
              consult
              consult-codesearch
              consult-dir
              consult-gh
              consult-lsp
              consult-notes
              consult-org-roam
              consult-projectile
              consult-todo
              corfu
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
              lsp-ui
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
              org-link-beautify
              org-links
              org-mind-map
              org-modern

              (callPackage ./packages/_org-modern-indent.nix {
                inherit (pkgs) fetchFromGitHub;
                inherit (epkgs) melpaBuild;
              })

              org-roam
              org-roam-ui
              page-break-lines
              projectile
              projectile-ripgrep
              pulsar
              ripgrep
              shfmt
              tab-line-nerd-icons
              use-package
              vertico
              vterm
              which-key
              with-editor
              with-emacs
              xclip
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
