(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(rspec-use-rake-when-possible nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;   ___                       _ 
;;  / __|___ _ _  ___ _ _ __ _| |
;; | (_ / -_) ' \/ -_) '_/ _` | |
;;  \___\___|_||_\___|_| \__,_|_|                               

;; https://github.com/emacs-helm/helm-ls-git/issues/29
(require 'eieio)
(add-to-list 'load-path "~/.emacs.d/private")
;; Zen Mode :)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
;; melpa
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))
;; saving desktop
(desktop-save-mode 1)
;; package management
(require 'use-package)
(setq use-package-always-ensure t)
;; smartparens
(use-package smartparens-config
  :ensure smartparens)
(smartparens-global-mode t)
;; auto-complete
(use-package auto-complete
  :ensure t)
(ac-config-default)
;; flycheck
(use-package flycheck
  :ensure t)
(add-hook 'after-init-hook #'global-flycheck-mode)
;; reload buffer when file modified
(global-auto-revert-mode t)
;; duplicating line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(global-set-key (kbd "C-;") 'duplicate-line)
;; window transformation
(use-package transpose-frame
  :ensure t)
;; eshell colors
(add-hook 'eshell-preoutput-filter-functions  'ansi-color-apply)
;; full screen on f11
(defun fullscreen (&optional f)
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
             '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
(global-set-key [f11] 'fullscreen)
;; auto-scroll
(setq compilation-scroll-output t)
;; window switching
(use-package ace-window
  :ensure t)
(global-set-key (kbd "M-[") 'ace-window)
;; free key bindings
(use-package free-keys
  :ensure t)
;; projectile
(use-package projectile
  :ensure t)
(setq projectile-enable-caching t)
(projectile-global-mode)
;; helm
(use-package async
  :ensure t)
(use-package helm
  :ensure t)
(use-package helm-projectile
  :ensure t)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(use-package helm-ls-git
  :ensure t)
(global-set-key (kbd "C-c g") 'helm-ls-git-ls)
(use-package helm-descbinds
  :ensure t)
(use-package helm-firefox
  :ensure t)
(use-package fireplace
  :ensure t)
;; snippets
(use-package yasnippet
  :ensure t)
(setq ac-sources '(ac-source-semantic ac-source-yasnippet))
(yas-global-mode 1)
;; C-tab for snippet completion
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)

;;  ___      _         
;; | _ \_  _| |__ _  _ 
;; |   / || | '_ \ || |
;; |_|_\\_,_|_.__/\_, |
;;                |__/ 

;; Rvm
(require 'rvm)
(rvm-use-default)
;; rsense
(setq rsense-home (expand-file-name "~/opt/rsense-0.3"))
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'cl)
(add-hook 'ruby-mode-hook 'robe-mode)
(use-package rsense
  :ensure t)
;; rspec
(add-to-list 'load-path "/home/panjan/.emacs.d/elpa/rspec-mode-20150727.1418/")
(use-package rspec-mode
  :ensure t)
(setq compilation-scroll-output t)
(setq rspec-use-rvm t)
;; rspec + yasnippet
(eval-after-load 'rspec-mode
 '(rspec-install-snippets))
;; robe
(use-package robe
  :ensure t)
(global-set-key (kbd "M-.") 'robe-jump)
;; robe + ac
(add-hook 'robe-mode-hook 'ac-robe-setup)
;; robe + rvm
(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))
;; ruby-refactor
;;(add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch)

;;     _                          _      _   
;;  _ | |__ ___ ____ _ ___ __ _ _(_)_ __| |_ 
;; | || / _` \ V / _` (_-</ _| '_| | '_ \  _|
;;  \__/\__,_|\_/\__,_/__/\__|_| |_| .__/\__|
;;                                 |_|       
;;  sudo npm install -g jshint

;; js2-mode
(use-package js2-mode
  :ensure js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; Tern
(use-package tern
  :ensure t)
(use-package tern-auto-complete
  :ensure t)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))
(use-package grunt
  :ensure t)
