(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (setq dashboard-startup-banner 2)
  (setq dashboard-banner-logo-title "")
  (setq dashboard-center-content t)
  ;; (setq dashboard-vertically-center-content t)
  (setq dashboard-navigation-cycle t)
  (setq dashboard-heading-shorcut-format " [%s]")
  (setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal
  (setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package
  ;; 守护进程
  ;; (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

  ;; 设置启动页内容
  (setq dashboard-items '((recents . 50)))
  ;; (setq dashboard-show-recent-files t)
  ;; (setq dashboard-show-bookmarks t)
  ;; (setq dashboard-show-projects t)
  ;; (setq dashboard-items-default-length 50)
  )

;; 自动刷新
(defun my-dashboard-refresh ()
  "Refresh the dashboard when switching to the dashboard buffer."
  (when (equal (buffer-name) "*dashboard*")
    (dashboard-refresh-buffer)
    ))

(add-hook 'window-configuration-change-hook 'my-dashboard-refresh)
