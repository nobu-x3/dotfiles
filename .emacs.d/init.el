(setq package-enable-at-startup nil
      inhibit-startup-message   t
      frame-resize-pixelwise    t  ; fine resize
      package-native-compile    t) ; native compile packages
(scroll-bar-mode -1)               ; disable scrollbar
(tool-bar-mode -1)                 ; disable toolbar
(tooltip-mode -1)                  ; disable tooltips
(set-fringe-mode 10)               ; give some breathing room
(menu-bar-mode -1)                 ; disable menubar
(blink-cursor-mode 0)              ; disable blinking cursor
(setq frame-inhibit-implied-resize t)
(setq inhibit-compacting-font-caches t)
(defvar file-name-handler-alist-original file-name-handler-alist)

;; Every file opened and loaded by Emacs will run through this list to check for a proper handler for the file, but during startup, it won’t need any of them.
(setq file-name-handler-alist nil)
(setq site-run-file nil)

;; defer garbage collection
(setq gc-cons-threshold 100000000)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Set gc-cons-threshold Smaller for Interactive Use
;; A large gc-cons-threshold may cause freezing and stuttering during long-term interactive use. If you experience freezing, decrease this amount, if you experience stuttering, increase this amount.
(defvar better-gc-cons-threshold (* 128 1024 1024) ; 128mb
  "The default value to use for `gc-cons-threshold'.

If you experience freezing, decrease this.  If you experience stuttering, increase this.")
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold better-gc-cons-threshold)
            (setq file-name-handler-alist file-name-handler-alist-original)
            (makunbound 'file-name-handler-alist-original)))

;; Garbage Collect when Emacs is out of focus and avoid garbage collection when using minibuffer.
(add-hook 'emacs-startup-hook
          (lambda ()
            (if (boundp 'after-focus-change-function)
                (add-function :after after-focus-change-function
                              (lambda ()
                                (unless (frame-focus-state)
                                  (garbage-collect))))
              (add-hook 'after-focus-change-function 'garbage-collect))
            (defun gc-minibuffer-setup-hook ()
              (setq gc-cons-threshold (* better-gc-cons-threshold 2)))

            (defun gc-minibuffer-exit-hook ()
              (garbage-collect)
              (setq gc-cons-threshold better-gc-cons-threshold))

            (add-hook 'minibuffer-setup-hook #'gc-minibuffer-setup-hook)
            (add-hook 'minibuffer-exit-hook #'gc-minibuffer-exit-hook)))

(setq
 user-full-name "Dominik Kurasbediani"
 user-mail-address "dominik.kurasbediani@gmail.com"
 user-login-name "nobu")

;; I never want to keep trailing spaces in my files, which is why I’m doing this:
(add-hook 'before-save-hook #'whitespace-cleanup)

;; I don’t understand why some people add two spaces behind a full stop, I sure don’t. Let’s tell Emacs.
(setq-default sentence-end-double-space nil)

;; There is a minor mode in Emacs which allows having a finer way of jumping from word to word: global-subword-mode. It detects if what Emacs usually considers a word can be understood as several words, as in camelCase words, and allows us to jump words on this finer level.
(global-subword-mode 1)

;;Lastly, I want the default mode for Emacs to be Emacs Lisp.
(setq-default initial-major-mode 'emacs-lisp-mode)

;; Indentation
(setq-default indent-tabs-mode nil)
(add-hook 'prog-mode-hook (lambda () (setq indent-tabs-mode nil)))

;; As nice as Emacs is, it isn’t very polite or clean by default: open a file, and it will create backup files in the same directory. But then, when you open your directory with your favourite file manager and see almost all of your files duplicated with a ~ appended to the filename, it looks really uncomfortable! This is why I prefer to tell Emacs to keep its backup files to itself in a directory it only will access.
(setq backup-directory-alist `(("." . ,(expand-file-name ".tmp/backups/"
                                                         user-emacs-directory))))
;; It also loves to litter its init.el with custom variables here and there, but the thing is: I regenerate my init.el each time I tangle this file! How can I keep Emacs from adding stuff that will be almost immediately lost? Did someone say custom file?
(setq-default custom-file (expand-file-name ".custom.el" user-emacs-directory))
(when (file-exists-p custom-file) ; Don’t forget to load it, we still need it
  (load custom-file))

(setq-default initial-scratch-message nil)

(setq undo-limit        100000000)

(setq window-combination-resize t) ; take new window space from all other windows

;; Visual stuff
(setq visible-bell t)
(setq x-stretch-cursor t)


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
        deadgrep
        tree-sitter
        zig-mode
        ))
; (if (eq system-type 'windows-nt)
;     (add-to-list 'vterm))
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
(setq evil-undo-system 'undo-redo)
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

(require 'tree-sitter)
(defun c-mode-config ()
    (lsp)
    (tree-sitter-hl-mode)
    (evil-define-key 'normal 'global (kbd "]]") nil)
    (evil-define-key 'normal 'global (kbd "[[") nil)
    (evil-define-key 'normal 'global (kbd "]]") #'c-end-of-defun)
    (evil-define-key 'normal 'global (kbd "[[") #'c-beginning-of-defun))
(add-hook 'c-mode-hook 'c-mode-config)
(add-hook 'c++-mode-hook 'c-mode-config)
(require 'beacon)
(beacon-mode 1)

(use-package
 centaur-tabs
 :demand
 :config
 (centaur-tabs-group-by-projectile-project)
 (setq centaur-tabs-adjust-buffer-order 'right)
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
   '(tree-sitter-langs
     tree-sitter
     all-the-icons-nerd-fonts
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

 (setq projectile-project-search-path '("~/projects"))

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
(evil-define-key 'normal 'global (kbd "}") #'forward-paragraph)
(evil-define-key 'normal 'global (kbd "{") #'backward-paragraph)
(evil-define-key 'normal 'global (kbd "f") #'evil-find-char)
(evil-define-key 'normal 'global (kbd "<leader>r n") #'lsp-rename)
(evil-define-key 'normal 'global (kbd "] d") #'next-error)
(evil-define-key 'normal 'global (kbd "[ d") #'previous-error)
(evil-define-key
 'normal 'global (kbd "g h") #'lsp-clangd-find-other-file)
(evil-define-key 'normal 'global (kbd "g t") nil)
(evil-define-key 'normal 'global (kbd "g T") nil)
(evil-define-key 'normal 'global (kbd "g t") #'centaur-tabs-forward-tab)
(evil-define-key 'normal 'global (kbd "g T") #'centaur-tabs-backward-tab)
(evil-define-key 'normal 'global (kbd "<leader>gt") #'switch-to-buffer)
(evil-define-key 'normal 'global (kbd "g d") #'lsp-find-definition)
(evil-define-key 'normal 'global (kbd "g r") #'lsp-find-references)
(evil-define-key 'normal 'global (kbd "<leader> f f") #'projectile-find-file)
(evil-define-key 'normal 'global (kbd "<leader> f g") nil)
(evil-define-key 'normal 'global (kbd "<leader> f g") #'deadgrep)
(evil-define-key 'normal 'global (kbd "C-s") #'lsp-ui-imenu)
(evil-define-key 'normal 'global (kbd "C-e") #'lsp-ui-flycheck-list)
(evil-define-key 'normal 'global (kbd "M-.") nil)
(evil-define-key 'normal 'global (kbd "M-.") #'dired)
(evil-define-key
 'normal 'global (kbd "C-a") #'lsp-execute-code-action)
(evil-define-key 'normal 'global (kbd "C-n") nil)
(evil-define-key 'normal 'global (kbd "C-n") #'treemacs)
(evil-define-key 'normal 'global (kbd "C-q") #'kill-current-buffer)
(evil-define-key
 'normal 'global (kbd "<leader>F") #'lsp-format-buffer)
(evil-define-key 'normal 'global (kbd "<leader> d s") #'dap-debug)
(evil-define-key 'normal 'global (kbd "<leader> d r") #'dap-debug-restart)
(evil-define-key 'normal 'global (kbd "<leader> d b") #'dap-breakpoint-toggle)
(evil-define-key 'normal 'global (kbd "<leader> d n") #'dap-next)
(evil-define-key 'normal 'global (kbd "<leader> d i") #'dap-step-in)
(evil-define-key 'normal 'global (kbd "<leader> d o") #'dap-step-out)
(evil-define-key 'normal 'global (kbd "<leader> d h") #'dap-hydra)

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

(add-to-list 'load-path "~/.emacs.d/plugins_submodules/p4.el")
(require 'p4)
(evil-define-key 'normal 'global (kbd "<leader> p a") #'p4-add)
(evil-define-key 'normal 'global (kbd "<leader> p c") #'p4-client)
(evil-define-key 'normal 'global (kbd "<leader> p e") #'p4-edit)
(evil-define-key 'normal 'global (kbd "<leader> p s") #'p4-submit)
(evil-define-key 'normal 'global (kbd "<leader> p u") #'p4-update)

;; (projectile-register-project-type 'zig '("build.zig")
;;                                :project-file "build.zig"
;;                                :compile "zig build"
;;                                :run "zig build run"
;;                                :test "zig test")

(use-package dap-mode
             :after lsp
             :defer t
             :config
             (dap-ui-mode)
             (dap-ui-controls-mode 1)
             (add-hook 'dap-stopped-hook
                       (lambda(arg)(call-interactively #'dap-hydra)))
             :init
             ;; zig
             (with-eval-after-load 'zig-mode
                                   (require 'dap-lldb)
                                   (require 'dap-gdb-lldb)
                (dap-register-debug-template
                  "Zig::LLDB Run"
                  (list :type "lldb"
                        :request "launch"
                        :name "LLDB::Run"
                        :program "${workspaceFolder}/bin/sandbox"
                        :cwd "${workspaceFolder}")
                  )
             )
)

;; EmacsLisp
 (use-package eldoc
   :defer t
   :after company
   :init
   (eldoc-add-command 'company-complete-selection
                      'company-complete-common
                      'company-capf
                      'company-abort))
 (use-package elisp-mode
   :requires smartparens
   :config
   (add-hook 'emacs-lisp-mode-hook (lambda () (smartparens-mode -1))))

;; Modeline
(require 'time)
(setq display-time-format "%Y-%m-%d %H:%M")
(display-time-mode 1) ; display time in modeline
(column-number-mode)

;; Frame title
(setq frame-title-format
      '(""
        "%b"
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p) " ◉ %s" "  ●  %s - Emacs") project-name))))))

(projectile-mode +1)
