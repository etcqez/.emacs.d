(defun my/disable-tool-bar-in-new-frames (frame)
  "Disable tool bar in new frames."
  (with-selected-frame frame
    (menu-bar-mode -1)))

(add-hook 'after-make-frame-functions 'my/disable-tool-bar-in-new-frames)
