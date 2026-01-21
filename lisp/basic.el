;; 强制所有通过 emacsclient 创建的新窗口夺取焦点
(add-hook 'server-after-make-frame-hook
          (lambda ()
            (let ((frame (selected-frame)))
              ;; 1. 强制使窗口可见
              (make-frame-visible frame)
              ;; 2. 提升窗口层级
              (raise-frame frame)
              ;; 3. 夺取系统输入焦点
              (select-frame-set-input-focus frame)
              ;; 4. 针对 GNOME/Wayland 的额外补丁：取消最小化状态
              (set-frame-parameter frame 'visibility t))))

;; 终端粘贴时替换
(defadvice xterm-paste (before delete-selection activate)
  "Before pasting, delete the selection if there is one."
  (when (use-region-p)
    (delete-region (region-beginning) (region-end))))


(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)
(setq create-lockfiles nil)

;; 禁用光标闪烁
(blink-cursor-mode 0)
(setq inhibit-startup-message t)
;; Hide advertisement from minibuffer
(defun display-startup-echo-area-message ()
  (message ""))

(tooltip-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode 1)
(save-place-mode 1)
(column-number-mode 1)
(electric-pair-mode 1)

;; 命令历史 文件历史
(setq recentf-max-saved-items 50) ;; 或者更大
(recentf-mode 1)
(savehist-mode 1)

(setopt use-short-answers t)

;; 终端鼠标支持
(xterm-mouse-mode 1)
(pixel-scroll-precision-mode 1)
;; (setq scroll-step 1)
;; (setq scroll-margin 5)
;; (setq scroll-conservatively 9999)

;; 启动守护进程
(when (display-graphic-p)  ; 检查是否在图形界面中
  (use-package server
    :config
    (unless (server-running-p)
      (server-start)
      ))
  )

;; 粘贴时删除选区
(use-package delsel
  :config
  (delete-selection-mode +1))

(unless (boundp 'image-scaling-factor)
  (defvar image-scaling-factor 1.0
    "缩放因子用于图像显示。Emacs 27.1 之前版本兼容备用。"))
(show-paren-mode -1)


;; (setq track-eol t)
(setq mode-require-final-newline nil)
(setq require-final-newline nil)
