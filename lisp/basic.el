(setq scroll-step 1)
(setq scroll-margin 5)
(setq scroll-conservatively 9999)

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

;; 启动守护进程
(when (display-graphic-p)  ; 检查是否在图形界面中
(use-package server
  :config
  (unless (server-running-p)
    (server-start)
    ))
  )       ; 启动 server

;; 粘贴时删除选区
(use-package delsel
  :config
  (delete-selection-mode +1))

;; 阻止超出文本
;; (setq track-eol t)
;; (setq mode-require-final-newline nil)
;; (setq require-final-newline nil)
;; (defun my-prevent-point-max ()
;;   (unless (minibufferp)
;;     (when (>= (point) (point-max))
;;       (goto-char (max (1- (point-max)) (point-min))))))
;; (add-hook 'post-command-hook #'my-prevent-point-max)

(unless (boundp 'image-scaling-factor)
  (defvar image-scaling-factor 1.0
    "缩放因子用于图像显示。Emacs 27.1 之前版本兼容备用。"))
(show-paren-mode -1)


(setq track-eol t)
(setq mode-require-final-newline nil)
(setq require-final-newline nil)

(defun my-prevent-point-beyond-last-char ()
  "阻止光标超出最后一行文本末尾，绝对不允许到最后空行。
允许停在最后字符后，但不能换行。"
  (unless (minibufferp)
    (let* ((max-pos (point-max))
           (last-line-end (save-excursion
                            (goto-char max-pos)
                            (if (> (point) (point-min))
                                (1- (point))  ;; 最后字符位置
                              (point)))))
      (when (> (point) last-line-end)
        (goto-char last-line-end)))))

(add-hook 'post-command-hook #'my-prevent-point-beyond-last-char)
