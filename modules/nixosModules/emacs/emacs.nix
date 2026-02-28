{
  flake.nixosModules.emacs =
    { pkgs, config, ... }:
    {

      environment.systemPackages = with pkgs; [
        fd
        ripgrep
        ripgrep-all

        bash-language-server # bash-language server
        clang-tools # For C development format
        emacs-lsp-booster # Dependency for eglot-booster
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

        unzip # For Unzipping zip files
        vips # Has vlpsthumbnail for image preview in dirvish
        _7zz-rar # for archive files preview

        # Emacsclient needs to be restarted after every rebuild
        (pkgs.writeShellScriptBin "remacs" ''
          systemctl --user restart emacs
        '')

        # Alias for emacsclient
        (pkgs.writeShellScriptBin "ec" ''
          ${config.services.emacs.package}/bin/emacsclient -a \"\" -c $@
        '')

        (pkgs.writeShellScriptBin "epkgs" ''
          nix-env -f '<nixpkgs>' -qaP -A services
        '')
      ];
      services.emacs = {
        enable = true;
        install = true;
        defaultEditor = true;

        package =
          with pkgs;
          ((emacsPackagesFor emacs-pgtk).emacsWithPackages (
            epkgs: with epkgs; [
              ace-window # Better window navigation
              babel # Babel languages setup
              breadcrumb # Works well with eglot
              cape # Provides Completion At Point Extensions
              colorful-mode # Highlight CSS Colors
              consult # Set up minibuffer actions and
              consult-dir # Really good package to traverse long distance directories using minibuffer
              consult-eglot # Consult+eglot
              consult-eglot-embark # Consult + embark + eglot
              consult-notes # For managing notes
              consult-org-roam
              consult-projectile # Needed for consult-project-switch, I guess(?)
              consult-todo
              corfu # Completion UI
              dash # It's a library that's needed by emacs for a lot of things
              dashboard
              diff-hl
              dired-open-with # Open files with external programs form dired
              dirvish # best dired extension, no mini-packages
              doom-modeline
              doom-themes # For tokyo-night theme
              eglot # Lightweight lsp engine
              eglot-booster # Make eglot faster
              elfeed
              elfeed-dashboard
              elfeed-org
              emacs
              embark
              embark-consult
              embark-org-roam
              emms # For Music player
              envrc # Integrate emacs with direnv
              eshell-git-prompt
              eshell-vterm
              exec-path-from-shell
              forge
              hl-todo # Highlight the TODO keywords in a lot of buffers
              indent-bars # Indentation guide bars
              info-colors # Prettify info mode
              json-mode
              ligature
              magit
              marginalia
              markdown-mode
              media-progress-dirvish # display media progress in dirvish
              multiple-cursors
              multi-vterm # Manage multiple vterm buffers
              nerd-icons
              nerd-icons-completion
              nerd-icons-corfu
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
              pulsar # Cool cursor animations in emacs when changing b/w contexts
              rainbow-delimiters # colorful delimiters
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

              use-package # Basic necessity
              vertico # completion ui
              vterm # Terminal inside emacs
              vterm-toggle
              which-key # YKI
              with-editor # handle $EDITOR in different in-emacs environment
              with-emacs
              yasnippet
            ]
          ));
      };
    };
}
