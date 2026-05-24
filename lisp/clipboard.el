;; ;; 全局设置禁用 kill 命令的剪贴板交互
;; (setq select-enable-clipboard nil)
;; (setq save-interprogram-paste-before-kill nil)

;; ;; 使用 advice 机制确保特定命令不使用剪贴板
;; (defun my/disable-clipboard-for-kill (orig-fun &rest args)
;;   "临时禁用剪贴板操作"
;;   (let ((select-enable-clipboard nil)
;;         (interprogram-cut-function nil))
;;     (apply orig-fun args)))

;; ;; 为特定命令添加 advice
;; (advice-add 'kill-line :around #'my/disable-clipboard-for-kill)
;; (advice-add 'backward-kill-word :around #'my/disable-clipboard-for-kill)
;; (advice-add 'kill-region :around #'my/disable-clipboard-for-kill) ; 所有剪切操作

;; (use-package xclip
;;   :ensure t
;;   :config
;;   (xclip-mode 1))

(defun my-copy-to-clipboard (text)
  (let ((process-connection-type nil))
    (let ((proc (start-process "wl-copy" nil "wl-copy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(defun my-paste-from-clipboard ()
  (shell-command-to-string "wl-paste -n | tr -d '\r'"))

(setq interprogram-cut-function 'my-copy-to-clipboard)
(setq interprogram-paste-function 'my-paste-from-clipboard)