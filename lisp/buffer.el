;; emacs让帮助窗口出现在minibuffer上面
(setq display-buffer-alist
      '(("*Help*" . ((display-buffer-at-bottom) (window-height . 10)))))