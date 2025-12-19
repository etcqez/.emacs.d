(add-to-list 'warning-suppress-types '(files))
(setq confirm-kill-emacs 'y-or-n-p)
(require 'package)
(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))
(package-initialize)
(setq use-package-always-ensure t)
(unless package-archive-contents
  (package-refresh-contents))
(require 'use-package)'
(setq use-package-always-ensure t)

;; mac
(when (eq system-type 'darwin)
  (load "~/.emacs.d/lisp/mac.el"))

;; 图形界面
(when (display-graphic-p)
  (load "~/.emacs.d/graphic.el"))

(load "~/.emacs.d/lisp/basic.el")
(load "~/.emacs.d/lisp/meow.el")
(load "~/.emacs.d/lisp/meow_customize.el")
(load "~/.emacs.d/lisp/keybindings.el")
;; (load "~/.emacs.d/lisp/meow2.el")
(load "~/.emacs.d/lisp/smartparens.el")
(load "~/.emacs.d/lisp/avy.el")
(load "~/.emacs.d/lisp/buffer.el")
(load "~/.emacs.d/lisp/ace-window.el")
(load "~/.emacs.d/lisp/undo.el")
(load "~/.emacs.d/lisp/font.el")
(load "~/.emacs.d/lisp/dashboard.el")
(load "~/.emacs.d/lisp/icon.el")
(load "~/.emacs.d/lisp/surround.el")
(load "~/.emacs.d/lisp/indent.el")

(load "~/.emacs.d/lisp/theme.el")
(load "~/.emacs.d/lisp/color.el")

(load "~/.emacs.d/lisp/vertico.el")
(load "~/.emacs.d/lisp/corfu.el")
(load "~/.emacs.d/lisp/neotree.el")
(load "~/.emacs.d/lisp/git.el")
(load "~/.emacs.d/lisp/expreg.el")
(load "~/.emacs.d/lisp/mouse.el")
(load "~/.emacs.d/lisp/chinese.el")
(load "~/.emacs.d/lisp/clipboard.el")
;; (load "~/.emacs.d/lisp/org-roam.el")
(load "~/.emacs.d/lisp/org.el")
(load "~/.emacs.d/lisp/expand-region.el")

;; (load "~/.emacs.d/lisp/projectile.el")
;; (load "~/.emacs.d/lisp/outline.el")
(load "~/.emacs.d/lisp/daemon.el")
;; (load "~/.emacs.d/lisp/isearch.el")
;; (load "~/.emacs.d/lisp/xml.el")
  
(setq ns-pop-up-frames nil)

;; 解决forfu报错
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-background-face ((t (:background unspecified :foreground "gray60"))))
 '(avy-goto-char-timer-face ((t (:foreground "skyblue" :background unspecified))))
 '(avy-lead-face ((t (:foreground "red" :background unspecified))))
 '(avy-lead-face-0 ((t (:foreground "red" :background unspecified))))
 '(avy-lead-face-1 ((t (:foreground "red" :background unspecified))))
 '(avy-lead-face-2 ((t (:foreground "red" :background unspecified))))
 '(gnus-group-news-low ((t nil)))
 '(gnus-group-news-low-empty ((t nil))))






;; ============================================================
;; 自动记忆窗口大小和位置
;; ============================================================

;; 1. 定义保存配置文件的路径 (存放在 ~/.emacs.d/.frame-params)
(defvar my-frame-params-file (locate-user-emacs-file ".frame-params"))

;; 2. 保存窗口参数的函数
(defun my-save-frame-params ()
  "退出时保存当前 Frame 的几何参数"
  (when (display-graphic-p) ;; 只有在图形界面下才执行
    (with-temp-file my-frame-params-file
      (insert (prin1-to-string
               (list 
                ;; 保存宽高
                (cons 'width (frame-parameter nil 'width))
                (cons 'height (frame-parameter nil 'height))
                ;; 保存位置 (左上角坐标)
                (cons 'left (frame-parameter nil 'left))
                (cons 'top (frame-parameter nil 'top))
                ;; 保存全屏/最大化状态
                (cons 'fullscreen (frame-parameter nil 'fullscreen))))))))

;; 3. 读取并应用窗口参数的函数
(defun my-load-frame-params ()
  "启动时读取并恢复 Frame 参数"
  (when (and (display-graphic-p) (file-exists-p my-frame-params-file))
    (let* ((params (with-temp-buffer
                     (insert-file-contents my-frame-params-file)
                     (read (current-buffer))))
           (fullscreen (alist-get 'fullscreen params)))
      
      ;; 应用位置和大小
      (modify-frame-parameters nil params)
      
      ;; 额外处理全屏状态 (防止有时不生效)
      (when fullscreen
        (set-frame-parameter nil 'fullscreen fullscreen)))))

;; 4. 绑定钩子 (Hook)
;; 退出 Emacs 时保存
(add-hook 'kill-emacs-hook #'my-save-frame-params)
;; 窗口系统初始化完成后加载 (比 after-init-hook 更适合处理 GUI 尺寸)
(add-hook 'window-setup-hook #'my-load-frame-params)
















(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(package-selected-packages nil))
