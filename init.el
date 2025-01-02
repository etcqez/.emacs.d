;; clm/open-command-log-buffer C-c o
;; evll C-c C-e

;; scrolloff
(setq scroll-step 1)
(setq scroll-margin 5)
(setq scroll-conservatively 9999)

;; 字体
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font 12"))
;(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font 12")

;; 禁用光标闪烁
(blink-cursor-mode 0)

(setq inhibit-startup-message t)
(global-display-line-numbers-mode 1)

(set-fringe-mode 10)        ; Give some breathing room
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode 1)
(save-place-mode 1)

;; 命令历史 文件历史
(recentf-mode 1)
(savehist-mode 1)

(setq inhibit-startup-message t)
(global-display-line-numbers-mode 1)

;; 关闭自动保存
(setq make-backup-files nil)  ;; 禁止创建备份文件
(setq auto-save-list-file-prefix nil)  ;; 关闭自动保存列表文件

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

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

;; 终端复制
(use-package xclip
  :ensure t
  :config
  (xclip-mode 1)
  )

(load "~/.emacs.d/lisp/theme.el")
(load "~/.emacs.d/lisp/miscellaneous.el")
(load "~/.emacs.d/lisp/color.el")
(load "~/.emacs.d/lisp/dashboard.el")

(load "~/.emacs.d/lisp/meow.el")
(load "~/.emacs.d/lisp/avy.el")
(load "~/.emacs.d/lisp/vertico.el")
(load "~/.emacs.d/lisp/completion.el")
(load "~/.emacs.d/lisp/format-all.el")
(load "~/.emacs.d/lisp/keybindings.el")
(load "~/.emacs.d/lisp/neotree.el")
(load "~/.emacs.d/lisp/built-in.el")















;;; 优先加载 my-priority-file.el
;(load "~/.emacs.d/lisp/priority-file.el")
;
;;; 然后加载其他 .el 文件
;(dolist (file (directory-files "~/.emacs.d/lisp/" t "\\.el$"))
;  (unless (string= file "~/.emacs.d/lisp/priority-file.el")
;    (load file)))
