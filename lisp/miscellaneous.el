(setq undo-fu-session-directory "/tmp/")

;; emacs让帮助窗口出现在minibuffer上面
(setq display-buffer-alist
      '(("*Help*" . ((display-buffer-at-bottom) (window-height . 10)))))

(setq ring-bell-function 'ignore)
