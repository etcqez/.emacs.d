(use-package expand-region
  :ensure t
  :config
  ;; 在 meow normal state 中绑定到回车键
  (with-eval-after-load 'meow
    (define-key meow-normal-state-keymap (kbd "RET") 'er/expand-region)))
