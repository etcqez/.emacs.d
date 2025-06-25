;; 全局设置禁用 kill 命令的剪贴板交互
(setq select-enable-clipboard nil)
(setq save-interprogram-paste-before-kill nil)

;; 使用 advice 机制确保特定命令不使用剪贴板
(defun my/disable-clipboard-for-kill (orig-fun &rest args)
  "临时禁用剪贴板操作"
  (let ((select-enable-clipboard nil)
        (interprogram-cut-function nil))
    (apply orig-fun args)))

;; 为特定命令添加 advice
(advice-add 'kill-line :around #'my/disable-clipboard-for-kill)
(advice-add 'backward-kill-word :around #'my/disable-clipboard-for-kill)
(advice-add 'kill-region :around #'my/disable-clipboard-for-kill) ; 所有剪切操作
