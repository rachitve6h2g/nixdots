;; -*- lexical-binding: t; -*-

(use-package dash
  :init
  (global-dash-fontify-mode))

(let ((backup-dir (expand-file-name "backups/" user-emacs-directory))
      (autosave-dir (expand-file-name "auto-saves/" user-emacs-directory)))

  (make-directory backup-dir t)
  (make-directory autosave-dir t)
  
  ;; Backups
  (setq backup-directory-alist
	`(("." . ,backup-dir))
	backup-by-copying t
	delete-old-versions t
	kept-new-versions 10
	kept-old-versions 5
	version-control t)

  ;; Auto-saves
  (setq auto-save-file-name-transforms
	`((".*" ,autosave-dir t))))

(use-package doom-themes
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  (doom-themes-treemacs-theme "doom-colors")
  
  :config
  ;; 3. Load the theme now that the path is known
  ;; Load the custom theme path
  (add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

  ;; 2. Set the variant variable BEFORE load-theme is called
  (setq doom-gruvbox-material-dark-variant "hard")

  (load-theme 'doom-gruvbox-material t)

  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(setq visible-bell t)
(fringe-mode 0)

;; Enable cursorline like thing in vim for these modes
(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'hl-line-mode))

;; Use Relative Line Numbers
(column-number-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;; Turn off line-numbers in some modes:
(dolist (mode '(org-mode-hook
  		term-mode-hook
  		shell-mode-hook
  		treemacs-mode-hook
  		eshell-mode-hook
  		vterm-mode-hook
  		reader-mode-hook))

  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Add frame borders and window dividers
(modify-all-frames-parameters
 '((right-divider-width . 10)
   (internal-border-width . 10)))
(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))

(set-face-background 'fringe (face-attribute 'default :background))

;; This function is called in the font setup block,
;; because emacs client is not calling it propely.
(defun my/variables-custom ()
  (setq line-spacing 0.2)) ;; Increase line-spacing a little

(defun my/frame-face-setup (frame)
  (with-selected-frame frame
    (set-face-attribute 'fixed-pitch frame
                        :family "Iosevka Nerd Font"
                        :height 1.0)

    (set-face-attribute 'variable-pitch frame
                        :family "Inter"
                        :height 1.13
                        :weight 'regular)))

(add-hook 'after-make-frame-functions #'my/frame-face-setup)

(use-package ligature
  :load-path "path-to-ligature-repo"
  :config
  ;; Enable all Iosevka ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("<---" "<--"  "<<-" "<-" "->" "-->" "--->" "<->" "<-->" "<--->" "<---->" "<!--"
                                       "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
                                       "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
                                       ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++" "+++"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

;; General usage
(use-package nerd-icons)

;; Use in ibuffer
(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

;; For completion in minibuffer
(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  :hook (marginalia-mode nerd-icons-completion-marginalia-setup))

(use-package dired
  :config
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")
  ;; this command is useful when you want to close the window of `dirvish-side'
  ;; automatically when opening a file
  (put 'dired-find-alternate-file 'disabled nil))

(use-package dirvish
  :ensure t
  :init
  (dirvish-override-dired-mode)
  :custom
  (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
   '(("h" "~/"                          "Home")
     ("d" "~/Downloads/"                "Downloads")
     ("m" "/mnt/"                       "Drives")
     ("s" "/ssh:my-remote-server"      "SSH server")
     ("e" "/sudo:root@localhost:/etc"  "Modify program settings")
     ("t" "~/.local/share/Trash/files/" "TrashCan")))

  :config
  ;; (dirvish-peek-mode)             ; Preview files in minibuffer
  ;; (dirvish-side-follow-mode)      ; similar to `treemacs-follow-mode'

  (setq delete-by-moving-to-trash t) ;; does what it says
  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index)))
  (setq dirvish-attributes           ; The order *MATTERS* for some attributes
        '(vc-state subtree-state nerd-icons collapse git-msg file-time file-size)
        dirvish-side-attributes
        '(vc-state nerd-icons collapse file-size))
  ;; open large directory (over 20000 files) asynchronously with `fd' command
  (setq dirvish-large-directory-threshold 20000)
  (setq dirvish-subtree-state-style 'nerd)
  (setq dirvish-path-separators (list
				 (format "  %s " (nerd-icons-codicon "nf-cod-home"))
				 (format "  %s " (nerd-icons-codicon "nf-cod-root_folder"))
				 (format " %s " (nerd-icons-faicon "nf-fa-angle_right"))))
  (dirvish-peek-mode) ;; Preview files in minibuffer
  (dirvish-side-follow-mode)
  
  :bind ; Bind `dirvish-fd|dirvish-side|dirvish-dwim' as you see fit
  (("C-c f" . dirvish)
   :map dirvish-mode-map               ; Dirvish inherits `dired-mode-map'
   (";"   . dired-up-directory)        ; So you can adjust `dired' bindings here
   ("?"   . dirvish-dispatch)          ; [?] a helpful cheatsheet
   ("a"   . dirvish-setup-menu)        ; [a]ttributes settings:`t' toggles mtime, `f' toggles fullframe, etc.
   ("f"   . dirvish-file-info-menu)    ; [f]ile info
   ("o"   . dirvish-quick-access)      ; [o]pen `dirvish-quick-access-entries'
   ("s"   . dirvish-quicksort)         ; [s]ort flie list
   ("r"   . dirvish-history-jump)      ; [r]ecent visited
   ("l"   . dirvish-ls-switches-menu)  ; [l]s command flags
   ("v"   . dirvish-vc-menu)           ; [v]ersion control commands
   ("*"   . dirvish-mark-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ("TAB" . dirvish-subtree-toggle)
   ("M-f" . dirvish-history-go-forward)
   ("M-b" . dirvish-history-go-backward)
   ("M-e" . dirvish-emerge-menu)))

(use-package media-progress-dirvish
  :after dirvish
  :config
  (media-progress-dirvish-setup))

(use-package dired-x
  :config
  ;; Make dired-omit-mode hide all "dotfiles"
  (setq dired-omit-files
	(concat dired-omit-files "\\|^\\..*$")))

(use-package treemacs-nerd-icons
  :config
  (treemacs-nerd-icons-config))

(use-package dired-open-with
  :after dirvish)

(use-package doom-modeline
  :custom
  (doom-modeline-hud t)
  (doom-modeline-major-mode-color-icon t)
  
  :init
  (doom-modeline-mode 1))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :custom
  (which-key-idle-delay 1)
  :config
  (which-key-mode))

;; Enable vertico
(use-package vertico
  :custom
  (vertico-scroll-margin 0)
  (vertico-count 10)
  (vertico-resize t)
  (vertico-cycle t)
  :init
  (vertico-mode))

;; Presist history over emacs restarts.
(use-package savehist
  :init
  (savehist-mode))



;; Marginalia for margins
(use-package marginalia
  :bind (:map minibuffer-local-map
	      ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package dashboard
  :custom
  (initial-buffer-choice 'dashboard-open) ;; When using emacsclient
  (dashboard-center-content t)
  (dashboard-vertically-center-content t)
  (dashboard-navigation-cycle t)

  ;; Using icons in dashboard
  (dashboard-display-icons-p t)
  (dashboard-icon-type 'nerd-icons)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)

  ;; (setq dashboard-projects-switch-function (lambda (&rest _) consult-projectile-switch-project))
  
  (dashboard-projects-switch-function #'projectile-switch-project)
  (dashboard-startup-banner "~/.face")
  (dashboard-image-banner-max-heigth 200)
  (dashboard-image-banner-max-width 200)
  (dashboard-banner-logo-title "お帰りなさい!")

  ;; Customize which items are displayed
  (dashboard-items '((recents   . 5)
                     (bookmarks . 5)
                     (projects  . 5)
                     (agenda    . 5)
                     (registers . 5)))
  
  ;; Customize item shortcuts
  (dashboard-item-shortcuts '((recents   . "r")
                              (bookmarks . "m")
                              (projects  . "p")
                              (agenda    . "a")
                              (registers . "e")))

  ;; Customize the widgets on the dashboard
  (dashboard-startupify-list '(dashboard-insert-banner
                               dashboard-insert-newline
                               dashboard-insert-banner-title
                               dashboard-insert-newline
                               dashboard-insert-navigator
                               dashboard-insert-newline
                               dashboard-insert-init-info
                               dashboard-insert-items
                               dashboard-insert-newline
                               dashboard-insert-footer))
  
  ;; modify icon height and vertical adjust
  ;; (dashboard-icon-file-height 1.75)
  ;; (dashboard-icon-file-v-adjust -0.125)
  ;; (dashboard-heading-icon-height 1.75)
  ;; (dashboard-heading-icon-v-adjust -0.125)
  
  :hook
  (server-after-make-frame . 'dashboard-open) ;; When using emacsclient
  (dashboard-mode . page-break-lines-mode)
  
  :config
  (dashboard-setup-startup-hook))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
	hl-todo-keyword-faces
	'(
          ;; Critical
          ("FIXME" . "#ea6962") ; red
          ("BUG"   . "#ea6962")

          ;; Urgent but not broken
          ("TODO"  . "#e78a4e") ; orange

          ;; Suspicious / tech debt
          ("HACK"  . "#d8a657") ; yellow
          ("XXX"   . "#d8a657")

          ;; Informational
          ("NOTE"  . "#7daea3") ; aqua
          ("INFO"  . "#7daea3")

          ;; Future ideas
          ("IDEA"  . "#a9b665") ; green
          )))

(use-package pulsar
  :bind
  ( :map global-map
    ("C-x l" . pulsar-pulse-line) ;; overrides 'count-lines-page'
    ("C-x L" . pulsar-highlight-permanently-dwim))
  :init
  (pulsar-global-mode 1)
  :config
  (setq pulsar-delay 0.055)
  (setq pulsar-iterations 5)
  (setq pulsar-face 'pulsar-green)
  (setq pulsar-region-face 'pulsar-yellow)
  (setq pulsar-highlight-face 'pulsar-magenta)
  :hook
  (next-error . #'pulsar-pulse-line)
  (minibuffer-setup-hook . #'pulsar-pulse-line))

(use-package info-colors
  :hook (Info-selection . info-colors-fontify-node))

(use-package no-littering)

(defun my/org-mode-setup ()
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  (org-indent-mode))

(defun my/org-font-setup ()
  ;; Resize Org headings
  (dolist (face '((org-level-1 . 1.35)
                  (org-level-2 . 1.3)
                  (org-level-3 . 1.2)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil
			:font "Inter"
			:weight 'bold
			:height (cdr face)))

  ;; Make the document title a bit bigger
  (set-face-attribute 'org-document-title nil
		      :font "Inter"
		      :weight 'bold
		      :height 1.8)
  
  (require 'org-indent)
  
  (set-face-attribute 'org-indent nil
		      :inherit '(org-hide fixed-pitch))
  
  (set-face-attribute 'org-block nil
		      :inherit 'fixed-pitch
		      :height 0.9)
  
  (set-face-attribute 'org-code nil
		      :inherit 'fixed-pitch
		      :height 0.9)
  
  (set-face-attribute 'org-verbatim nil
		      :inherit 'fixed-pitch
		      :height 0.9)
  
  (set-face-attribute 'org-special-keyword nil
		      :inherit '(font-lock-comment-face fixed-pitch))
  
  (set-face-attribute 'org-meta-line nil
		      :inherit '(font-lock-comment-face fixed-pitch))
  
  (set-face-attribute 'org-checkbox nil
		      :inherit 'fixed-pitch))


(use-package org
  :commands (org-capture org-agenda)
  :hook
  (org-mode . my/org-mode-setup)
  (org-mode . my/org-font-setup)
  :custom
  (org-hide-leading-stars t)
  (org-adapt-indentation t)
  (org-src-fontify-natively t) ;; native src fonts
  (org-src-tab-acts-natively t) ;; let tab act as it would when writing code
  (org-ellipsis "  ")
  (org-link-descriptive t)
  
  :config
  ;; Enable org templates
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  

  ;; Configuring org-capture

  ;; First set the default org notes directory
  (setq org-directory "~/org"
    	org-default-notes-file (expand-file-name "tasks.org" org-directory))
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-refile-targets
	'(("archive.org" :maxlevel . 1)
	  ("tasks.org" :maxlevel . 1)))

  ;; Save org buffers after refiling
  (advice-add 'org-refile
	      :after 'org-save-all-org-buffers)
  
  (setq org-capture-templates
	'(("t" "Tasks / Projects")
	  ("tt" "Task" entry
           (file+headline "tasks.org" "Inbox")
           "* TODO %?\n  %U\n %a\n %i" :empty-lines 1)

	  ("j" "Journal Entries")
          ("jj" "Journal" entry
           (file+olp+datetree "~/org/journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)))

  (defun my/org-capture-task ()
    (interactive)
    (org-capture nil "tt"))

  (defun my/org-capture-journal ()
    (interactive)
    (org-capture nil "jj"))

  (keymap-global-set "C-c t" #'my/org-capture-task)
  (keymap-global-set "C-c j" #'my/org-capture-journal))

(use-package org-modern
  :custom
  (org-auto-align-tags t)
  (org-tags-column 0)
  (org-fold-catch-invisible-edits 'show-and-error)
  (org-special-ctrl-a/e t)
  (org-insert-heading-respect-content t)
  
  ;; Hide markups or not
  (org-pretty-entities t)
  (org-agenda-tags-column 0)
  
  :hook
  
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda)
  
  :config
  (global-org-modern-mode))

;; Use org-modern indent for using org-indent with org-modern
(use-package org-modern-indent
  :defer t
  :custom (org-startup-indented t) ;; Adds a sort of '#+STARTUP: indent' to all org files
  :hook (org-mode . org-modern-indent-mode))

(use-package org-auto-tangle
  :after org
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(use-package olivetti
  :custom (olivetti-body-width 100)
  :hook (org-mode . olivetti-mode))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (C . t))))

(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/org"))
  (org-roam-completion-everywhere t)
  :config
  (org-roam-db-autosync-mode))

;; Configure the base engine
(use-package ispell
  :custom
  (ispell-program-name "aspell")
  (ispell-extra-args '("--sug-mode=ultra")))

;; Configure the real-time interface
(use-package flyspell
  :hook ((org-mode . flyspell-mode)
         (text-mode . flyspell-mode)))

(use-package ace-window
  :bind ("M-o" . ace-window)
  :custom
  (aw-keys '(?a ?r ?s ?t ?g ?n ?e ?i ?o)))

(use-package vterm)

;; Use Multi vterm to create multiple vterm buffers
(use-package multi-vterm
  :config
  (setq multi-vterm-dedicated-window-height 50))

(use-package vterm-toggle
  :bind
  (:map global-map
	("C-c v v" . vterm-toggle-cd))
  (:map vterm-mode-map
	("s-n" . vterm-toggle-forward)
	("s-p" . vterm-toggle-backward)))

(keymap-global-set "C-x C-b" #'ibuffer)

(use-package magit
  :after nerd-icons
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  (magit-format-file-function #'magit-format-file-nerd-icons))

(use-package forge
  :after magit)

(use-package with-editor :ensure nil)

(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode) ;; Show in programming buffers
	 (magit-post-refresh . #'diff-hl-magit-post-refresh)
	 (dired-mode . diff-hl-dired-mode))) ;; Also show in dired buffers

(use-package colorful-mode
  :custom
  (colorful-use-prefix t)
  (colorful-only-strings 'only-prog)
  (css-fontify-colors nil)
  :config
  (global-colorful-mode t)
  (add-to-list 'global-colorful-modes 'helpful-mode))

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package projectile
  :init
  (projectile-mode 1)
  
  :custom
  (projectile-project-search-path '("~/Development/"
  				    "~/nixdots/"))
  
  :bind (:map projectile-mode-map
  	      ("C-c p" . projectile-command-map)))

;; Also use consult-projectile
(use-package consult-projectile)

(use-package smartparens
  :hook (prog-mode text-mode markdown-mode) ;; add `smartparens-mode` to these hooks
  :config
  ;; load default config
  (require 'smartparens-config))

(use-package eglot
  :ensure nil
  :hook ((c-mode c++-mode python-mode nix-ts-mode) . eglot-ensure)
  :config
  ;; Optional performance tuning
  (setq eglot-autoshutdown t
	eglot-send-changes-idle-time 0.5))

(use-package eglot-booster
  :after eglot
  :config (eglot-booster-mode))

(use-package breadcrumb
  :init (breadcrumb-mode)
  :config
  (setq which-func-functions #'(breadcrumb-imenu-crumbs))
  (setq breadcrumb-imenu-crumb-separator "  "))


(use-package imenu
  :ensure nil
  :config
  (setq imenu-auto-rescan t))

(use-package nixfmt
  :hook (nix-ts-mode . nixfmt-on-save-mode))

(use-package shfmt
  :hook (sh-mode . shfmt-on-save-mode)
  :custom
  ;; Use 2 spaces for indentation
  (shfmt-indent 2)

  ;; Optional but sane defaults
  (shfmt-arguments '("-i" "2" "-ci")))

(use-package nix-ts-mode
  :mode "\\.nix\\'"
  :init
  ;; Add to your init.el before loading nix-ts-mode
  (setq treesit-font-lock-level 4))

;; TAB-only configuration
(use-package corfu
  :custom
  (corfu-auto t)               ;; Enable auto completion
  (corfu-preselect 'directory) ;; Select the first candidate, except for directories

  :init
  (global-corfu-mode)

  :config
  ;; Free the RET key for less intrusive behavior.
  ;; Option 1: Unbind RET completely
  ;; (keymap-unset corfu-map "RET")
  ;; Option 2: Use RET only in shell modes
  (keymap-set corfu-map "RET" `( menu-item "" nil :filter
                                 ,(lambda (&optional _)
                                    (and (derived-mode-p 'eshell-mode 'comint-mode)
                                         #'corfu-send)))))

(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a menmonic key.
  :bind ("C-x c" . cape-prefix-map)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

(use-package nerd-icons-corfu
  :after (corfu nerd-icons)
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; Orderless completions
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (completion-pcm-leading-wildcard t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g r" . consult-grep-match)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-fd)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult-source-bookmark consult-source-file-register
   consult-source-recent-file consult-source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
  )

(use-package consult-dir
  :custom
  ;; List projectile directories for use with consult
  (consult-dir-project-list-function #'consult-dir-projectile-dirs)
  
  :bind (("C-x C-d" . consult-dir)
	 :map minibuffer-local-completion-map
	 ("C-x C-d" . consult-dir)
	 ("C-x C-j" . consult-dir-jump-file)))

(use-package consult-notes
  :commands (consult-notes
	     consult-notes-search-in-all-notes
	     consult-notes-org-roam-find-node
	     consult-notes-org-roam-find-node-relation))

(use-package embark
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; Add Embark to the mouse context menu. Also enable `context-menu-mode'.
  ;; (context-menu-mode 1)
  ;; (add-hook 'context-menu-functions #'embark-context-menu 100)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))

  ;; add which key integration in embark
  (defun embark-which-key-indicator ()
    "An embark indicator that displays keymaps using which-key.
The which-key help message will show the type and value of the
current target followed by an ellipsis if there are further
targets."
    (lambda (&optional keymap targets prefix)
      (if (null keymap)
          (which-key--hide-popup-ignore-command)
	(which-key--show-keymap
	 (if (eq (plist-get (car targets) :type) 'embark-become)
             "Become"
           (format "Act on %s '%s'%s"
                   (plist-get (car targets) :type)
                   (embark--truncate-target (plist-get (car targets) :target))
                   (if (cdr targets) "…" "")))
	 (if prefix
             (pcase (lookup-key keymap prefix 'accept-default)
               ((and (pred keymapp) km) km)
               (_ (key-binding prefix 'accept-default)))
           keymap)
	 nil nil t (lambda (binding)
                     (not (string-suffix-p "-argument" (cdr binding))))))))

  (setq embark-indicators
	'(embark-which-key-indicator
	  embark-highlight-indicator
	  embark-isearch-highlight-indicator))

  (defun embark-hide-which-key-indicator (fn &rest args)
    "Hide the which-key indicator immediately when using the completing-read prompter."
    (which-key--hide-popup-ignore-command)
    (let ((embark-indicators
           (remq #'embark-which-key-indicator embark-indicators)))
      (apply fn args)))

  (advice-add #'embark-completing-read-prompter
              :around #'embark-hide-which-key-indicator))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package indent-bars
  :hook ((prog-mode nix-ts-mode) . indent-bars-mode)) ; or whichever modes you prefer

;; credit: Lukas Barth at https://www.lukas-barth.net/blog/emacs-wsl-copy-clipboard/
(setopt select-active-regions nil)

(setopt select-enable-clipboard 't)
(setopt select-enable-primary nil)
(setopt interprogram-cut-function #'gui-select-text)

(use-package reader
  :commands
  (reader-mode)
  :hook
  (reader-mode . (lambda () (display-line-numbers-mode -1))))


;; The new version is still expecting a function that it does not provide.
(with-eval-after-load 'reader
  (unless (fboundp 'reader-current-doc-pagenumber)
    (defalias 'reader-current-doc-pagenumber
      #'reader-dyn--current-doc-pagenumber)))

(use-package emms
  :custom
  (emms-player-list '(emms-player-mpv))
  (emms-source-file-default-directory "~/Music/")
  (emms-show-format "Playing: %s")
  (emms-info-functions '(emms-info-native))
  (emms-browser-covers #'emms-browser-cache-thumbnail-async)
  (emms-browser-thumbnail-small-size 64)
  (emms-browser-thumbnail-medium-size 128)
  :init
  (require 'emms-setup)
  (emms-all))
