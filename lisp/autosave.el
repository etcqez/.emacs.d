;; 切换buffer自动保存
;; (defadvice switch-to-buffer (before save-buffer-now activate)
;;            (when buffer-file-name (save-buffer)))
;; (defadvice other-window (before other-window-now activate)
;;            (when buffer-file-name (save-buffer)))
;; (defadvice other-frame (before other-frame-now activate)
;;            (when buffer-file-name (save-buffer)))

;; 如果经过一段时间后没有任何操作，则自动保存缓冲区。
;; (use-package files
;;   :ensure nil
;;   :config
;;   (setq auto-save-visited-interval 30)
;;   (auto-save-visited-mode +1))

;; 聚焦时保存所有缓冲区
;; (defun my/save-all-buffers ()
;;   (save-some-buffers "!"))
;; (add-hook 'focus-out-hook #'my/save-all-buffers)
