;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Ludovico Piero"
      user-mail-address "ludovicopiero@pm.me")

(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 15)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font" :size 15)
      doom-big-font (font-spec :family "Iosevka Nerd Font" :size 18))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; Default spelling dictionary is English
(setq ispell-dictionary "english")

;; Get system notifications through libnotify
(setq alert-default-style 'libnotify)

;; Enables Nixos-installed packages to be loaded
(require 'package)
(setq package-enable-at-startup nil) 
(package-initialize)

;; Set location of custom.el
;; (setq custom-file "~/.emacs.d/custom.el")

;; Always follow symlinks.
(setq vc-follow-symlinks t)

;; enable beacon here
;; (beacon-mode 0)

;; Set rust lsp server
(setq lsp-rust-server 'rust-analyzer)

;; Set Doom theme
(setq doom-theme 'doom-ayu-dark)
(setq doom-themes-treemacs-config "doom-colors")
(with-eval-after-load 'doom-themes
  (doom-themes-treemacs-config))

(setq display-line-numbers-type 'relative)

(setq org-directory "~/Documents/org/")

(setq shell-file-name "/home/ludovico/.nix-profile/bin/zsh"
      vterm-max-scrollback 5000)
(setq shell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))
(map! :leader
      :desc "Eshell" "e s" #'eshell
      :desc "Eshell popup toggle" "e t" #'+eshell/toggle
      :desc "Counsel eshell history" "e h" #'counsel-esh-history
      :desc "Vterm popup toggle" "v t" #'+vterm/toggle)

;; Nix
(setq-hook! 'nix-mode-hook +format-with 'nixpkgs-fmt)
(set-formatter! 'nixpkgs-fmt "nixpkgs-fmt" :modes 'nix-mode)
(after! nix-mode
  (set-formatter! 'nixpkgs-fmt "nixpkgs-fmt" :modes '(nix-mode))
  (puthash 'nixpkgs-fmt "nixpkgs-fmt" format-all--executable-table))

;; Change rust lsp server
(use-package! rustic
  :defer t
  :custom
  (rustic-lsp-server 'rust-analyzer)
  :config
  (when (featurep 'evil)
    (add-hook! 'rustic-popup-mode-hook #'evil-emacs-state)))

;; Change doom modeline to user letter instead of icon
(use-package! doom-modeline
  :defer t
  :custom
  (doom-modeline-modal-icon nil))

;; Treemacs
(setq treemacs-width 30)
