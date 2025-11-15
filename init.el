;; (defun my/raise-frame ()
;;   "Raise the selected frame to the front."
;;   (interactive)
;;   (select-frame-set-input-focus (selected-frame)))
;; (defun my/raise-frame-and-open-file (file)
;;   "Raise the selected frame to the front and open FILE."
;;   (interactive "FFile to open: ")
;;   (select-frame-set-input-focus (selected-frame))
;;   (find-file file))

;; (add-hook 'window-setup-hook 'my/raise-frame);; scrolloff
(setq scroll-step 1)
(setq scroll-margin 5)
(setq scroll-conservatively 9999)

;; 检查 custom.el 是否存在
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; 禁用光标闪烁
(blink-cursor-mode 0)

(setq inhibit-startup-message t)
;(set-fringe-mode 10)        ; Give some breathing room
;(scroll-bar-mode -1)        ; Disable visible scrollbar
;(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode 1)
(setq line-spacing 0.4)
(save-place-mode 1)
(column-number-mode 1)

;; 命令历史 文件历史
(setq recentf-max-saved-items 50) ;; 或者更大
(recentf-mode 1)
(savehist-mode 1)

(setq inhibit-startup-message t)

;; Initialize package sources
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

;; (load "~/.emacs.d/lisp/meow2.el")
(load "~/.emacs.d/lisp/meow.el")
(load "~/.emacs.d/lisp/meow_customize.el")
(load "~/.emacs.d/lisp/undo.el")
(load "~/.emacs.d/lisp/dashboard.el")
(load "~/.emacs.d/lisp/theme.el")
(load "~/.emacs.d/lisp/color.el")
;; (load "~/.emacs.d/lisp/cnfont.el")

;; mac
(when (eq system-type 'darwin)
  (load "~/.emacs.d/lisp/mac.el"))

(load "~/.emacs.d/lisp/avy.el")
(load "~/.emacs.d/lisp/vertico.el")
(load "~/.emacs.d/lisp/consult.el")
(load "~/.emacs.d/lisp/completion.el")
(load "~/.emacs.d/lisp/format-all.el")
(load "~/.emacs.d/lisp/keybindings.el")
(load "~/.emacs.d/lisp/neotree.el")
(load "~/.emacs.d/lisp/isearch.el")
(load "~/.emacs.d/lisp/paren.el")
(load "~/.emacs.d/lisp/ace-window.el")
(load "~/.emacs.d/lisp/system.el")
(load "~/.emacs.d/lisp/git.el")
(load "~/.emacs.d/lisp/expreg.el")
(load "~/.emacs.d/lisp/daemon.el")
(load "~/.emacs.d/lisp/indent.el")
(load "~/.emacs.d/lisp/mouse.el")
(load "~/.emacs.d/lisp/chinese.el")
;; (load "~/.emacs.d/lisp/scratch.el")
(load "~/.emacs.d/lisp/clipboard.el")
(load "~/.emacs.d/lisp/org-roam.el")
(load "~/.emacs.d/lisp/org.el")
(load "~/.emacs.d/lisp/xml.el")
(load "~/.emacs.d/lisp/outline.el")
(load "~/.emacs.d/lisp/projectile.el")
(load "~/.emacs.d/lisp/expand-region.el")


;; (load "~/.emacs.d/lisp/jieba.el")
;; (load "~/.emacs.d/lisp/markdown.el")

(setopt use-short-answers t)

;; 启动守护进程
(when (display-graphic-p)  ; 检查是否在图形界面中
(use-package server
  :config
  (unless (server-running-p)
    (server-start)
    ))
  )       ; 启动 server

;; 终端鼠标支持
(xterm-mouse-mode 1)

;; 粘贴时删除选区
(use-package delsel
  :config
  (delete-selection-mode +1))

;; 当前帧打开文件
;(setq ns-pop-up-frames nil)

(unless (boundp 'image-scaling-factor)
  (defvar image-scaling-factor 1.0
    "缩放因子用于图像显示。Emacs 27.1 之前版本兼容备用。"))

;; 确保自动保存目录存在
(let ((auto-save-dir "~/.emacs.d/auto-saves/"))
  (unless (file-exists-p auto-save-dir)
    (make-directory auto-save-dir t)))

;; 设置自动保存文件位置
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/auto-saves/") t)))

;; 设置锁文件位置（与自动保存文件在同一目录）
(setq lock-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/auto-saves/") t)))

;; font
;; English font
(set-face-attribute 'default nil
  :font "FiraCode Nerd Font"
  ;; :style "Regular"
  :height 130)

;; Enable ligatures (Emacs 28+)
(use-package ligature
  :ensure t
  :config
  (ligature-set-ligatures 't '("www" "->" "=>" "::" ":=" "<=" ">=" "!=" "===" "!=="))
  (global-ligature-mode t))


;; (setq mode-line-format
;;       (list
;;        '(:eval (list (nyan-create)))
;;        ))


