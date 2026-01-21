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
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

  ;; 设置启动页内容
  (setq dashboard-items '((recents . 50)
			  (projects . 5)
			  (bookmarks . 5)
			  ))
  (setq dashboard-item-shortcuts '((recents   . "r")
                                   (bookmarks . "m")
                                   (projects  . "p")
                                   (agenda    . "a")
                                   (registers . "e")))
  ;; (setq dashboard-show-recent-files t)
  ;; (setq dashboard-show-bookmarks t)
  ;; (setq dashboard-show-projects t)
  ;; (setq dashboard-items-default-length 50)
  )
;; (defun my/disable-tool-bar-in-new-frames (frame)
;;   "Disable tool bar in new frames."
;;   (with-selected-frame frame
;;     (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
;;     (menu-bar-mode -1)))

;; (add-hook 'after-make-frame-functions 'my/disable-tool-bar-in-new-frames)












;; ==========================================================
;; 【下方为追加补丁，严禁改动上方任何内容及注释】
;; ==========================================================


;; --- 补丁 2：最近文件管理与即时刷新 ---
(require 'recentf)
(recentf-mode 1)

;; 实现文件即时排序：只要离开一个已打开的文件 buffer，就在后台立即重排顺序
(add-hook 'buffer-list-update-hook 
          (lambda () 
            (when (and buffer-file-name (not (derived-mode-p 'dashboard-mode)))
              (recentf-add-file buffer-file-name))))

;; (defun my/addon-smart-sync-dashboard ()
;;   "仅在确定已经在 Dashboard 模式时重绘列表、更新排序并归位光标。"
;;   (when (derived-mode-p 'dashboard-mode)
;;     (dashboard-refresh-buffer)
;;     (dashboard-jump-to-recents)))

;; ;; A. 初次加载完落位 (从顶层 Logo 跳到第一行文件)
;; (add-hook 'dashboard-after-initialize-hook #'dashboard-jump-to-recents)

;; ;; B. 联动刷新：每当切回 Dashboard (C-x b) 或焦点重新进入窗口时刷新
;; (add-hook 'window-buffer-change-functions (lambda (_) (my/addon-smart-sync-dashboard)))
;; (add-hook 'focus-in-hook #'my/addon-smart-sync-dashboard)
(defun my/addon-smart-sync-dashboard ()
  "仅在确定已经在 Dashboard 模式时重绘列表、更新排序并归位光标。"
  (when (and (derived-mode-p 'dashboard-mode)
             (get-buffer "*dashboard*"))  ; 确保当前处于 Dashboard 模式，并且 *dashboard* 缓冲区是活动的
    (dashboard-refresh-buffer)
    (dashboard-jump-to-recents)))

;; A. 初次加载完落位 (从顶层 Logo 跳到第一行文件)
(add-hook 'dashboard-after-initialize-hook #'dashboard-jump-to-recents)

;; B. 联动刷新：每当切回 Dashboard (C-x b) 或焦点重新进入窗口时刷新
(add-hook 'window-buffer-change-functions
          (lambda (_)
            (when (string= (buffer-name (window-buffer)) "*dashboard*")
              (my/addon-smart-sync-dashboard))))

(add-hook 'focus-in-hook #'my/addon-smart-sync-dashboard)

;; --- 补丁 3：图标显示变量补齐 ---
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

;; --- 补丁 4：焦点修复 (解决 GNOME 首键失灵，且防止 TTY 下报错) ---
(add-hook 'after-make-frame-functions 
          (lambda (f) 
            (run-with-timer 0.1 nil 
                            (lambda (fr) 
                              (when (and (frame-live-p fr) (display-graphic-p fr))
                                (select-frame-set-input-focus fr))) f)) t)