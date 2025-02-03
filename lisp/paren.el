(use-package paren
  :init
  (show-paren-mode +1)
  )

(use-package smartparens
  :config
  (smartparens-global-mode t)
  )

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
  )
