(defun my/disable-tool-bar-in-new-frames (frame)
  "Disable tool bar in new frames."
  (with-selected-frame frame
    (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
    (menu-bar-mode -1)))

(add-hook 'after-make-frame-functions 'my/disable-tool-bar-in-new-frames)
