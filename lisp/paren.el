(use-package paren
  :init
  (show-paren-mode +1)
  )

(use-package elec-pair
  :config
  (electric-pair-mode +1)
  )

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
  )
