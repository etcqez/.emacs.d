;; macos
(when (eq system-type 'darwin)  ;; 检查是否为 macOS
  (use-package osx-clipboard
    :ensure t
    :config
    ;; font
    (osx-clipboard-mode 1))
  
  ;; font
  (defun set-font-based-on-availability ()
    (if (member "Hack Nerd Font" (font-family-list))
	(setq default-frame-alist
              '((font . "Hack Nerd Font-15")))
      (setq default-frame-alist
            '((font . "Fira Code Nerd Font-15")))))
  ;; 调用函数以设置字体
  (set-font-based-on-availability)
  )

;; linux
(unless (eq system-type 'darwin)
  ;; 终端复制
  (use-package xclip
    :ensure t
    :config
    (xclip-mode 1))
  ;;
  ;; font
  (defun set-font-based-on-availability ()
    (if (member "Hack Nerd Font" (font-family-list))
	(setq default-frame-alist
              '((font . "Hack Nerd Font-11")))
      (setq default-frame-alist
            '((font . "Fira Code Nerd Font-11")))))
  ;; 调用函数以设置字体
  (set-font-based-on-availability)
  )
