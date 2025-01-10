(use-package nerd-icons)
(use-package nerd-icons-completion
  :hook (after-init . nerd-icons-completion-mode))
(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package powerline
  :ensure t
  :config
  ;; (powerline-center-evil-theme)
  )
(use-package airline-themes
  :ensure t
  :config
  )

(use-package nyan-mode
  :init
  (setq nyan-bar-length 24)
  (nyan-mode +1))

(use-package catppuccin-theme
  :ensure t
  :config
      (load-theme 'catppuccin :no-confirm)
      ;; (load-theme 'airline-doom-one t)
      )

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; emacs让帮助窗口出现在minibuffer上面
(setq display-buffer-alist
      '(("*Help*" . ((display-buffer-at-bottom) (window-height . 10)))))

(setq ring-bell-function 'ignore)

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode +1))
