{
  flake.homeModules.emacs =
    { pkgs, config, ... }:
    {
      stylix.targets.emacs = {
        opacity.override = rec {
          applications = 0.89;
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
            ec = "emacsclient -a \"\" -c";
            epkgs = "nix-env -f '<nixpkgs>' -qaP -A emacsPackages";
          };
        };
        emacs = {
          enable = true;
          package = pkgs.emacs-pgtk;
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
              doom-modeline
              emacs
              embark
              embark-consult
              embark-org-roam
              eshell-git-prompt
              eshell-vterm
              forge # For managing git interactions
              emms
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
              org-links
              org-link-beautify
              org-mind-map
              org-modern

              (callPackage ./packages/_org-modern-indent.nix {
                inherit (pkgs) fetchFromGitHub;
                inherit (epkgs) melpaBuild;
              })

              org-roam
              org-roam-ui
              projectile
              projectile-ripgrep
              pulsar
              ripgrep
              shfmt
              tab-line-nerd-icons
              use-package
              vertico
              # visual-fill-column # Try out olivetti 
              vterm
              which-key
              with-editor
              with-emacs
              xclip # For managing clipbaord
            ];

          extraConfig = "(setq standard-indent 2)";
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
