;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq user-full-name "Dominik Kurasbediani"
      user-mail-address "dominik.kurasbediani@gmail.com"
      projectile-project-search-path '("~/projects/")
      )
(setq lsp-clients-clangd-args '("-j=3"
				"--background-index"
				"--clang-tidy"
				"--completion-style=detailed"
				"--header-insertion=never"
				"--header-insertion-decorators=0"))
(setq flycheck-check-syntax-automatically '(mode-enabled save))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))
(setq +format-with-lsp nil)
(setq clang-format-style "file")
(setq doom-font (font-spec :family "Fira Code" :size 16)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(map! :leader "r n" #'lsp-rename)
(map! :n "] d" #'flycheck-next-error)
(map! :n "[ d" #'flycheck-previous-error)
(map! :n "g h" #'lsp-clangd-find-other-file)
(map! :n "g t" #'next-buffer)
(map! :n "g T" #'previous-buffer)
(map! :n "g d" #'+lookup/definition)
(map! :n "g r" #'+lookup/references)
(map! :n "f" #'evil-find-char)
(map! :n "F" #'evil-find-char-backward)
(map! :leader "f f" #'find-file)
(map! :n "C-s" #'lsp-ui-imenu)
(map! :n "C-e" #'lsp-ui-flycheck-list)
(map! :n "C-a" #'lsp-execute-code-action)
(map! :leader "f g" #'+default/search-project)
;; (map! :v "f g" #'+default/search-project-for-symbol-at-point)
(map! :n "C-n" nil)
(map! :n "C-n" #'+treemacs/toggle)
(map! :n "C-q" #'kill-current-buffer)
(map! :leader "h p" #'doom/open-private-config)
(map! :leader "F" #'lsp-format-buffer)
(map! :leader "a" #'lsp-execute-code-action)
(map! :leader "s p" #'projectile-switch-project)
(map! :leader "b r" #'ibuffer-update)
(map! :leader "d d" #'dired-create-directory)
(map! :leader "d f" #'dired-create-empty-file)
(map! :leader "c c" #'project-compile)

(map! :map dap-mode-map
      :leader
      :prefix ("D" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      ;; :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      :prefix ("D" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)

(use-package! tree-sitter
  :hook (prog-mode . turn-on-tree-sitter-mode)
  :hook (tree-sitter-after-on . tree-sitter-hl-mode)
  :config
  (require 'tree-sitter-langs)
  ;; This makes every node a link to a section of code
  (setq tree-sitter-debug-jump-buttons t
        ;; and this highlights the entire sub tree in your code
        tree-sitter-debug-highlight-jump-region t))


(setq doom-modeline-time t)
(load! "c3-mode.el")
(load! "jai-mode.el")

(setq dap-auto-configure-mode t)
(after! dap-mode (require 'dap-cpptools))
