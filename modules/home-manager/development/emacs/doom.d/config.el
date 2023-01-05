;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; TODO: Make doomemacs config look cleaner by separating files.
;;
;;; Code:
(setq user-full-name "Ludovico Piero"
      user-mail-address "ludovicopiero@pm.me")

(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 15 :weight 'medium :slant 'normal)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font" :size 15 :weight 'medium :slant 'normal)
      doom-big-font (font-spec :family "Iosevka Nerd Font" :size 20))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

;; Default spelling dictionary is English
(setq ispell-dictionary "english")

;; Set location of custom.el
;; (setq custom-file "~/.emacs.d/custom.el")

;; Enable Global word-wrap
(+global-word-wrap-mode +1)

;; Always follow symlinks.
(setq vc-follow-symlinks t)

;; Set Doom theme
(setq doom-theme 'doom-ayu-dark)
(setq doom-themes-treemacs-config "doom-colors")
(with-eval-after-load 'doom-themes
  (doom-themes-treemacs-config))

(setq display-line-numbers-type 'relative)

(setq org-directory "~/Documents/org/")

;; Change doom modeline to user letter instead of icon
(use-package! doom-modeline
  :defer t
  :custom
  (doom-modeline-modal-icon nil))

;; Enables Nixos-installed packages to be loaded
(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)

;; Nix
;; otherwise nix-mode will block on instantiating stuff
(setenv "NIX_REMOTE_SYSTEMS" "")
;; Set Nix Formatter
(setq-hook! 'nix-mode-hook +format-with 'nixpkgs-fmt)
(set-formatter! 'nixpkgs-fmt "nixpkgs-fmt" :modes 'nix-mode)
(after! nix-mode
  (set-formatter! 'nixpkgs-fmt "nixpkgs-fmt" :modes '(nix-mode))
  (puthash 'nixpkgs-fmt "nixpkgs-fmt" format-all--executable-table))
;; Change nix lsp server to nil
(use-package! lsp-mode
  :config
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.terragrunt-cache\\'")
  (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("nil"))
                    :major-modes '(nix-mode)
                    :server-id 'nix)))

;; Rust
;; Change rust lsp server
(use-package! rustic
  :defer t
  :custom
  (rustic-lsp-server 'rust-analyzer)
  :config
  (when (featurep 'evil)
    (add-hook! 'rustic-popup-mode-hook #'evil-emacs-state)))

;; Change doomemacs cursor
(setq evil-normal-state-cursor 'block
      evil-visual-state-cursor 'block
      evil-insert-state-cursor 'block
      evil-motion-state-cursor 'block
      evil-replace-state-cursor 'block
      evil-operator-state-cursor 'block)

;; Treemacs
(setq treemacs-width 30)

;; Copilot
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

;; remap ; to :
(map! :map evil-normal-state-map
      ";" #'evil-ex)

;; Discord Presence
(require 'elcord)
(setq elcord-quiet t)
(add-hook 'after-init-hook 'elcord-mode)

;; (provide 'config)
;;; config.el ends here
