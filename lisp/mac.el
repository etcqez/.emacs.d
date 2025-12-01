(global-set-key (kbd "s-v") 'clipboard-yank)
(global-set-key (kbd "s-c") 'meow-clipboard-save)
(global-set-key (kbd "s-x") 'meow-clipboard-kill)
(defadvice xterm-paste (before delete-selection activate)
  "Before pasting, delete the selection if there is one."
  (when (use-region-p)
    (delete-region (region-beginning) (region-end))))
