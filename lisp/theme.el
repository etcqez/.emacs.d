(use-package powerline
  :ensure t
  :config
  ;; (powerline-center-evil-theme)
  )

(use-package airline-themes
  :ensure t
  :config
  )
(use-package catppuccin-theme
  :ensure t
  :config
      (load-theme 'catppuccin :no-confirm)
      (load-theme 'airline-doom-one t)
      )

;; emacs让帮助窗口出现在minibuffer上面
(setq display-buffer-alist
      '(("*Help*" . ((display-buffer-at-bottom) (window-height . 10)))))

(setq ring-bell-function 'ignore)

(use-package hl-line
  :init
  (global-hl-line-mode +1))
