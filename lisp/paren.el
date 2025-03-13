;; (use-package paren
;;   :init
;;   (show-paren-mode +1)
;;   )

;; 当光标在括号里面 ，高度外面括号
(use-package highlight-parentheses
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
    ;; 自定义高亮颜色
  (setq highlight-parentheses-colors '("red" "green" "yellow" "blue"))
  )

;; 插入括号自动补全另一半
(use-package smartparens
  :config
  (smartparens-global-mode t)
  )

;; 高高所有括号
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )
