;; ;; macos
(when (eq system-type 'darwin)  ;; 检查是否为 macOS
  (use-package osx-clipboard
    :ensure t
    :config
    ;; font
    (osx-clipboard-mode 1))
  (add-to-list 'default-frame-alist '(font . "Hack Nerd Font-15"))
  )

;; linux
(unless (eq system-type 'darwin)
  ;; 终端复制
  (use-package xclip
    :ensure t
    :config
    (xclip-mode 1))
  )
