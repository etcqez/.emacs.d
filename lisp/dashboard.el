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
(defun my/disable-tool-bar-in-new-frames (frame)
  "Disable tool bar in new frames."
  (with-selected-frame frame
    (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
    (menu-bar-mode -1)))

(add-hook 'after-make-frame-functions 'my/disable-tool-bar-in-new-frames)












;; ==========================================================
;; 【下方为追加补丁，严禁改动上方任何内容及注释】
;; ==========================================================


;; ;; --- 补丁 2：最近文件管理与即时刷新 ---
;; (require 'recentf)
;; (recentf-mode 1)

;; ;; 实现文件即时排序：只要离开一个已打开的文件 buffer，就在后台立即重排顺序
;; (add-hook 'buffer-list-update-hook 
;;           (lambda () 
;;             (when (and buffer-file-name (not (derived-mode-p 'dashboard-mode)))
;;               (recentf-add-file buffer-file-name))))

;; (defun my/addon-smart-sync-dashboard ()
;;   "仅在确定已经在 Dashboard 模式时重绘列表、更新排序并归位光标。"
;;   (when (and (derived-mode-p 'dashboard-mode)
;;              (get-buffer "*dashboard*"))  ; 确保当前处于 Dashboard 模式，并且 *dashboard* 缓冲区是活动的
;;     (dashboard-refresh-buffer)
;;     (dashboard-jump-to-recents)))

;; ;; A. 初次加载完落位 (从顶层 Logo 跳到第一行文件)
;; (add-hook 'dashboard-after-initialize-hook #'dashboard-jump-to-recents)

;; ;; B. 联动刷新：每当切回 Dashboard (C-x b) 或焦点重新进入窗口时刷新
;; (add-hook 'window-buffer-change-functions
;;           (lambda (_)
;;             (when (string= (buffer-name (window-buffer)) "*dashboard*")
;;               (my/addon-smart-sync-dashboard))))

;; (add-hook 'focus-in-hook #'my/addon-smart-sync-dashboard)

;; --- 补丁 2：最近文件管理（支持命令行与 EmacsClient 记录） ---
;; (require 'recentf)
;; (setq recentf-max-menu-items 25)
;; (setq recentf-max-saved-items 100)
;; (recentf-mode 1)

;; 1. 处理 Emacsclient/Server 方式打开的文件
;; 当客户端访问文件时，强制记录并保存列表
(add-hook 'server-visit-hook
          (lambda ()
            (when (and buffer-file-name (file-exists-p buffer-file-name))
              (recentf-add-file buffer-file-name)
              (recentf-save-list))))

;; 2. 增强版的 buffer-list-update-hook (即时排序的核心)
(add-hook 'buffer-list-update-hook 
          (lambda () 
            (let ((file (buffer-file-name (current-buffer))))
              ;; 增加一个 (not (string-match-p "/tmp/" ...)) 之类的过滤是个好习惯
              (when (and file (file-exists-p file) (not (derived-mode-p 'dashboard-mode)))
                (recentf-add-file file)))))

;; 3. 针对命令行参数 (emacs test.txt) 打开的文件进行收割
;; 因为 startup 时钩子可能还没挂载，我们遍历一遍已打开的所有 buffer 放入记录
(add-hook 'emacs-startup-hook
          (lambda ()
            (dolist (buf (buffer-list))
              (let ((file (buffer-file-name buf)))
                (when (and file (file-exists-p file))
                  (recentf-add-file file))))
            ;; 处理完毕后保存一次
            (recentf-save-list)))

;; --- 联动 Dashboard 刷新逻辑保持不变 ---
(defun my/addon-smart-sync-dashboard ()
  "仅在确定已经在 Dashboard 模式时重绘列表并同步归位。"
  (when (and (derived-mode-p 'dashboard-mode)
             (get-buffer "*dashboard*"))
    (dashboard-refresh-buffer)
    (dashboard-jump-to-recents)))

;; 原有的 Hook 设置继续生效
(add-hook 'dashboard-after-initialize-hook #'dashboard-jump-to-recents)
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