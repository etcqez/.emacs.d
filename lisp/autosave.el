;; 切换buffer自动保存
(defadvice switch-to-buffer (before save-buffer-now activate)
           (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
           (when buffer-file-name (save-buffer)))
(defadvice other-frame (before other-frame-now activate)
           (when buffer-file-name (save-buffer)))

