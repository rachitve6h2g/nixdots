{
  flake.homeModules.emacs =
    { pkgs, config, ... }:
    {
      stylix = {
        targets.emacs = {
          enable = true;

          opacity.override = rec {
            applications = 0.9;
            desktop = applications;
          };

          fonts.override = {
            applications = 11;
          };
        };
      };

      home.packages = with pkgs; [
        bash-language-server # bash-language server
        clang-tools # For C development format
        ffmpegthumbnailer # For ready-player
        ffmpeg-full # For ready-player
        imagemagick # For rendering images inside org
        mediainfo # For viewing mediainfo inside emacs
        mpg123 # For music decoding in ready player
        nixd # nix server
        nixfmt # for formatting nix

        # TODO: write an issue for using mupdf's mutool for pdf preview in dirvish.
        # poppler # For viewing pdf metadata
        poppler-utils # for pdftoppm utility

        # Not needed when using emacs-reader package
        # poppler # For pdf reading

        shfmt # for formatting bash
        mupdf

        vips # Has vlpsthumbnail for image preview in dirvish
        _7zz-rar # for archive files preview

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
              dirvish # best dired extension, no mini-packages
              doom-modeline
              elfeed
              elfeed-dashboard
              elfeed-org
              emacs
              embark
              embark-consult
              embark-org-roam
              envrc # Integrate emacs with direnv
              eshell-git-prompt
              eshell-vterm
              exec-path-from-shell
              forge
              hl-todo # Highlight the TODO keywords in a lot of buffers
              info-colors # Prettify info mode
              json-mode
              ligature
              lsp-mode
              lsp-treemacs # For treemacs compatibility
              lsp-ui
              magit
              marginalia
              markdown-mode
              media-progress-dirvish # display media progress in dirvish
              multiple-cursors
              multi-vterm # Manage multiple vterm buffers
              nerd-icons
              nerd-icons-completion
              nerd-icons-corfu
              # nerd-icons-dired # Dirvish handles it
              nerd-icons-grep
              nerd-icons-ibuffer
              nerd-icons-xref
              nixfmt # https://github.com/purcell/emacs-nixfmt for editing nix
              # nix-mode # Already using nix-ts-mode
              nix-ts-mode
              no-littering
              olivetti
              orderless
              org
              org-auto-tangle
              org-dashboard
              org-modern

              (callPackage ./packages/_org-modern-indent.nix {
                inherit (pkgs) fetchFromGitHub;
                inherit (epkgs) melpaBuild;
              })

              (callPackage ./packages/_emacs-reader.nix {
                inherit (pkgs)
                  fetchFromGitea
                  pkg-config
                  gcc
                  mupdf
                  gnumake
                  ;

                inherit (epkgs) melpaBuild;
              })

              org-roam
              org-roam-ui
              page-break-lines
              # pdf-tools # For opening pdf's inside of emacs
              projectile
              projectile-ripgrep
              pulsar
              rainbow-delimiters
              ready-player # Music player for Emacs
              ripgrep
              saveplace-pdf-view # To save the last visited information in pdf-mode
              shfmt
              smartparens # For auto-parenthesis
              tab-line-nerd-icons
              transient # Used for improving UI
              treemacs-nerd-icons # For icons in header line

              # Tree-sitter
              (treesit-grammars.with-grammars (
                grammars: with grammars; [
                  tree-sitter-bash
                  tree-sitter-c
                  tree-sitter-nix
                ]
              ))

              use-package
              vertico
              vterm
              vterm-toggle
              which-key
              with-editor
              with-emacs
              yasnippet
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
