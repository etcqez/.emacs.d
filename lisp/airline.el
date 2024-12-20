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

(if (display-graphic-p)
    (progn
  (progn
    (setq term-default-bg-color "black")
    (setq term-default-fg-color "white")
    (add-hook 'after-init-hook 'global-hl-line-mode))))
