;(defun evil-paste-visual-yank ()
;  "执行粘贴、恢复视觉状态并剪切的组合命令。"
;  (interactive "p")
;  (evil-paste-after 1)           ;; 粘贴操作
;  (evil-visual-restore)        ;; 恢复视觉模式
;  (evil-yank)
;  (evil-normal-state))                 ;; 执行剪切操作
;
;(define-key evil-normal-state-map (key "C-p") 'my/evil-paste-visual-yank)
