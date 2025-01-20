(use-package dashboard
  :config
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (dashboard-setup-startup-hook)
  
  ;; 设置启动页内容
  (setq dashboard-items '((recents . 30)  ;; 显示最近打开的文件
                          (bookmarks . 5)  ;; 显示书签
                          (projects . 5))) ;; 显示项目
  (setq dashboard-show-recent-files t)
  (setq dashboard-show-bookmarks t)
  (setq dashboard-show-projects t))

;; 自动刷新
(defun my-dashboard-refresh ()
  "Refresh the dashboard when switching to the dashboard buffer."
  (when (equal (buffer-name) "*dashboard*")
    (dashboard-refresh-buffer)))

(add-hook 'window-configuration-change-hook 'my-dashboard-refresh)
