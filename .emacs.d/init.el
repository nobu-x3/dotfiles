(setq inhibit-startup-message t)

(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode -1) ; Disable the toolbar
(tooltip-mode -1) ; Disable tooltips
(set-fringe-mode 10) ; Give some breathing room
;(setq warning-minimum-level :emergency)

(menu-bar-mode -1) ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(setq org-directory "~/org/")

(require 'package)
(add-to-list
 'package-archives '("melpa" . "http://melpa.org/packages/")
 t)
(package-initialize)
(setq package-selected-packages
      '(lsp-mode
        lsp-ui
        yasnippet
        helm-lsp
        projectile
        centaur-tabs
        evil
        all-the-icons
        doom-themes
        vterm
        vterm-toggle
        hydra
        flycheck
        company
        avy
        which-key
        helm-xref
        dap-mode
        beacon
        evil-nerd-commenter
        suggest
        elisp-autofmt
	deadgrep))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; elisp stuff
(require 'suggest)
(use-package
 elisp-autofmt
 :commands (elisp-autofmt-mode elisp-autofmt-buffer)
 :hook (emacs-lisp-mode . elisp-autofmt-mode))

;; Enable Evil
(require 'evil)
(evil-mode 1)

(require 'evil-nerd-commenter)
(evil-define-key
 'normal 'global (kbd "g c") #'evilnc-comment-or-uncomment-lines)

(when (display-graphic-p)
  (require 'all-the-icons))
;; or
(use-package all-the-icons :if (display-graphic-p))

(use-package
 doom-themes
 :ensure t
 :config
 ;; Global settings (defaults)
 (setq
  doom-themes-enable-bold t ; if nil, bold is universally disabled
  doom-themes-enable-italic t) ; if nil, italics is universally disabled
 (load-theme 'doom-dracula t)

 ;; Enable flashing mode-line on errors
 (doom-themes-visual-bell-config)
 ;; Corrects (and improves) org-mode's native fontification.
 (doom-themes-org-config))

;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(defun c-mode-config ()
  (evil-define-key 'normal 'global (kbd "}") nil)
  (evil-define-key 'normal 'global (kbd "{") nil)
  (evil-define-key 'normal 'global (kbd "}") #'c-end-of-defun)
  (evil-define-key 'normal 'global (kbd "{") #'c-beginning-of-defun))
(add-hook 'c-mode-hook 'c-mode-config)
(add-hook 'c++-mode-hook 'c-mode-config)
(require 'beacon)
(beacon-mode 1)

(use-package
 centaur-tabs
 :demand
 :config
 (centaur-tabs-group-by-projectile-project)
 (centaur-tabs-enable-buffer-reordering)
 (setq
  centaur-tabs-mode 'over
  centaur-tabs-height 32
  centaur-tabs-set-icons t
  centaur-tabs-gray-out-icons 'buffer
  centaur-tabs-set-bar 'over
  centaur-tabs-set-modified-marker t
  centaur-tabs-modifier-marker "•")
 (centaur-tabs-mode t))
(setq
 gc-cons-threshold (* 100 1024 1024)
 read-process-output-max (* 1024 1024)
 company-idle-delay 0.0
 company-minimum-prefix-length 1
 lsp-idle-delay 0.1) ;; clangd is fast

(use-package vterm :ensure t)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons-nerd-fonts
     centaur-tabs
     doom-themes
     lsp-mode
     yasnippet
     helm-lsp
     projectile
     hydra
     flycheck
     company
     avy
     which-key
     helm-xref
     dap-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq
 user-full-name "Dominik Kurasbediani"
 user-mail-address "dominik.kurasbediani@gmail.com"
 projectile-project-search-path '("~/projects"))
(setq lsp-clients-clangd-args
      '("--background-index"
        "--clang-tidy"
        "--completion-style=detailed"
        "--header-insertion=never"
        "--header-insertion-decorators=0"))
(setq flycheck-check-syntax-automatically '(mode-enabled save))
(setq +format-with-lsp nil)

(setq clang-format-style "file")
(add-to-list 'default-frame-alist '(font . "Fira Code"))
(set-face-attribute 'default t :font "Fira Code" :height 160)

(evil-set-leader 'normal (kbd "<SPC>"))
(evil-define-key 'normal 'global (kbd "<leader>r n") #'lsp-rename)
(evil-define-key 'normal 'global (kbd "] d") #'next-error)
(evil-define-key 'normal 'global (kbd "[ d") #'previous-error)
(evil-define-key
 'normal 'global (kbd "g h") #'lsp-clangd-find-other-file)
(evil-define-key 'normal 'global (kbd "g t") nil)
(evil-define-key 'normal 'global (kbd "g T") nil)
(evil-define-key 'normal 'global (kbd "g t") #'next-buffer)
(evil-define-key 'normal 'global (kbd "g T") #'previous-buffer)
(evil-define-key 'normal 'global (kbd "g ?\t") #'switch-to-buffer)
(evil-define-key 'normal 'global (kbd "g d") #'lsp-find-definition)
(evil-define-key 'normal 'global (kbd "g r") #'lsp-find-references)
(evil-define-key 'normal 'global (kbd "f f") #'find-file)
(evil-define-key 'normal 'global (kbd "f g") nil)
(evil-define-key 'normal 'global (kbd "f g") #'deadgrep)
(evil-define-key 'normal 'global (kbd "C-s") #'lsp-ui-imenu)
(evil-define-key 'normal 'global (kbd "C-e") #'lsp-ui-flycheck-list)
(evil-define-key
 'normal 'global (kbd "C-a") #'lsp-execute-code-action)
(evil-define-key 'normal 'global (kbd "C-n") nil)
(evil-define-key 'normal 'global (kbd "C-q") #'kill-current-buffer)
(evil-define-key
 'normal 'global (kbd "<leader>f") #'lsp-format-buffer)

(global-unset-key (kbd "C-SPC"))
(defun open-config ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun switch-project ()
  (interactive)
  (projectile-discover-projects-in-search-path)
  (projectile-switch-project))

(evil-define-key 'normal 'global (kbd "<leader> h p") #'open-config)
(evil-define-key
 'normal 'global (kbd "<leader> s p") #'switch-project)

(global-set-key [f2] 'vterm-toggle)
(electric-pair-mode)
