(use-package neotree
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "C-t") 'neotree-toggle)
  (define-key evil-emacs-state-map (kbd "C-t") 'tneotree-toggle)
  ;; 设置为使用文件图标
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-theme 'icons)  ;; 启用图标主题

  ;; 在treemacs中, 使用emacs键绑定
  ;; (evil-set-initial-state 'treemacs-mode 'emacs)
  )
