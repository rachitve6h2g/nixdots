(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
;; (set-fringe-mode 10)
(menu-bar-mode -1)

(setq visible-bell t)

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
  		pdf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Add frame borders and window dividers
(modify-all-frames-parameters
 '((right-divider-width . 40)
   (internal-border-width . 40)))
(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))

(set-face-background 'fringe (face-attribute 'default :background))

(setq line-spacing 0.3) ;; Increase line-spacing a little

;; Font size
(set-face-attribute 'default nil :font "Maple Mono NF" :height 120)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :family "Maple Mono NF" :height 1.0)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 135 :weight 'regular)

(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode '("--" "---" "==" "===" "!=" "!==" "=!="
				       "=:=" "=/=" "<=" ">=" "&&" "&&&" "&=" "++" "+++" "***" ";;" "!!"
				       "??" "???" "?:" "?." "?=" "<:" ":<" ":>" ">:" "<:<" "<>" "<<<" ">>>"
				       "<<" ">>" "||" "-|" "_|_" "|-" "||-" "|=" "||=" "##" "###" "####"
				       "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:" "#!" "#=" "^=" "<$>" "<$"
				       "$>" "<+>" "<+" "+>" "<*>" "<*" "*>" "</" "</>" "/>" "<!--" "<#--"
				       "-->" "->" "->>" "<<-" "<-" "<=<" "=<<" "<<=" "<==" "<=>" "<==>"
				       "==>" "=>" "=>>" ">=>" ">>=" ">>-" ">-" "-<" "-<<" ">->" "<-<" "<-|"
				       "<=|" "|=>" "|->" "<->" "<~~" "<~" "<~>" "~~" "~~>" "~>" "~-" "-~"
				       "~@" "[||]" "|]" "[|" "|}" "{|" "[<" ">]" "|>" "<|" "||>" "<||"
				       "|||>" "<|||" "<|>" "..." ".." ".=" "..<" ".?" "::" ":::" ":=" "::="
				       ":?" ":?>" "//" "///" "/*" "*/" "/=" "//=" "/==" "@_" "__" "???"
				       "<:<" ";;;"))
  (global-ligature-mode ))

;; General usage
(use-package nerd-icons)

;; use with dired 
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; Use in ibuffer
(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

;; For completion in minibuffer
(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  :hook (marginalia-mode nerd-icons-completion-marginalia-setup))

(use-package doom-modeline
  :custom
  (doom-modeline-hud t)
  (doom-modeline-minor-modes t)
  (doom-modeline-enable-word-count t)
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

;; Orderless completions
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (completion-pcm-leading-wildcard t))

;; Marginalia for margins
(use-package marginalia
  :bind (:map minibuffer-local-map
	      ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package dashboard
  :custom
  (initial-buffer-choice 'dashboard-open)
  (dashboard-center-content t)
  (dashboard-vertically-center-content t)
  (dashboard-navigation-cycle t)

  ;; Using icons in dashboard
  (dashboard-display-icons-p t)
  (dashboard-icon-type 'nerd-icons)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)

  (dashboard-projects-switch-function 'consult-projectile-switch-project)
  
  :hook
  (server-after-make-frame . 'dashboard-open)
  
  :config
  (dashboard-setup-startup-hook))

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
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'bold :height (cdr face)))

  ;; Make the document title a bit bigger
  (set-face-attribute 'org-document-title nil :font "Cantarell" :weight
		      'bold :height 1.8)
  (require 'org-indent)
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
  (set-face-attribute 'org-block nil            :foreground nil :inherit
		      'fixed-pitch :height 0.85)
  (set-face-attribute 'org-code nil             :inherit '(shadow fixed-pitch) :height 0.85)
  (set-face-attribute 'org-indent nil           :inherit '(org-hide fixed-pitch) :height 0.85)
  (set-face-attribute 'org-verbatim nil         :inherit '(shadow fixed-pitch) :height 0.85)
  (set-face-attribute 'org-special-keyword nil  :inherit '(font-lock-comment-face
							   fixed-pitch))
  (set-face-attribute 'org-meta-line nil        :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil         :inherit 'fixed-pitch))


(use-package org
  :commands (org-capture org-agenda)
  :hook (org-mode . my/org-mode-setup)
  :custom
  (org-hide-leading-stars t)
  (org-adapt-indentation t)
  (org-src-fontify-natively t) ;; native src fonts
  (org-src-tab-acts-natively t) ;; let tab act as it would when writing code
  (org-ellipsis "  ")
  
  :config

  (my/org-font-setup)
  
  ;; Enable org templates
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp")))

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
   '((emacs-lisp . t))))

(use-package org-journal
  :defer t
  :custom
  (org-journal-dir "~/Documents/Journals/")
  (org-journal-date-format "%A, %d %B %Y")
  (org-journal-prefix-key "C-c j")
          
  :config
  ;; Add org-journal-dir to org-agenda-files
  (add-to-list 'org-agenda-files org-journal-dir))

(use-package ace-window
  :bind ("M-o" . ace-window))

(use-package vterm)

(keymap-global-set "C-x C-b" #'ibuffer)

(use-package magit
  :after nerd-icons
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  (magit-format-file-function #'magit-format-file-nerd-icons))

(use-package forge
  :after magit)

(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode) ;; Show in programming buffers
	 (magit-post-refresh . #'diff-hl-magit-post-refresh)
	 (dired-mode . diff-hl-dired-mode))) ;; Also show in dired buffers

(use-package lsp-mode
  :custom
  (lsp-keymap-prefix "C-c l")
  :hook
  ((nix-mode . lsp-deferred)
   (lsp-mode . lsp-enable-which-key-integration)) ;; Enable which key integration
  :commands (lsp lsp-deferred))

(use-package nixfmt
  :hook (nix-mode . nixfmt-on-save-mode))

(use-package xclip
  :custom
  (xclip-program "wl-copy")
  (select-enable-clipboard t)
  (select-enable-primary nil)
  :config
  (xclip-mode 1))
