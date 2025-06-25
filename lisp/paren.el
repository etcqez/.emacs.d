;; 当光标在括号里面 ，高度外面括号
;; (use-package highlight-parentheses
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
;;     ;; 自定义高亮颜色
;;   (setq highlight-parentheses-colors '("red" "green" "yellow" "blue"))
;;   )

;; 插入括号自动补全另一半
(use-package smartparens
  :config
  (smartparens-global-mode t)
  )

;; 高高所有括号
;; (use-package rainbow-delimiters
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;;   )
;; 自动补全括号/引号并缩进
(electric-pair-mode -1)  ; 自动补全对称符号
;; (setq electric-pair-preserve-balance t)  ; 保持对称平衡
;; (add-hook 'java-mode-hook 'indent-line-function)  ; Java 模式缩进
