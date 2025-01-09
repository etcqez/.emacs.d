;; clm/open-command-log-buffer C-c o
;; evll C-c C-e

;; scrolloff
(setq scroll-step 1)
(setq scroll-margin 5)
(setq scroll-conservatively 9999)

;; 字体
;; (add-to-list 'default-frame-alist '(font . "Hack Nerd Font 15") '(font . "FiraCode Nerd Font 15")
;; (set-face-attribute 'default nil :font "JetBrainsMono Nerd Font 12")
(defun set-font-based-on-availability ()
  "Set font to Hack Nerd Font if available, otherwise use Fira Code Nerd Font."
  (if (member "Hack Nerd Font" (font-family-list))
      (setq default-frame-alist
            '((font . "Hack Nerd Font-11")))
    (setq default-frame-alist
          '((font . "Fira Code Nerd Font-11")))))

;; 调用函数以设置字体
(set-font-based-on-availability)

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

;; 检查 custom.el 是否存在
(let ((custom-file (expand-file-name "custom.el" user-emacs-directory)))
  (if (file-exists-p custom-file)
      (load custom-file)
    (message "custom.el not found, skipping load.")))

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

(load "~/.emacs.d/lisp/dashboard.el")
(load "~/.emacs.d/lisp/meow.el")
(load "~/.emacs.d/lisp/theme.el")
(load "~/.emacs.d/lisp/undo.el")
(load "~/.emacs.d/lisp/color.el")

(load "~/.emacs.d/lisp/avy.el")
(load "~/.emacs.d/lisp/vertico.el")
(load "~/.emacs.d/lisp/consult.el")
(load "~/.emacs.d/lisp/completion.el")
(load "~/.emacs.d/lisp/format-all.el")
(load "~/.emacs.d/lisp/keybindings.el")
(load "~/.emacs.d/lisp/neotree.el")
(load "~/.emacs.d/lisp/isearch.el")
(load "~/.emacs.d/lisp/autosave.el")
(load "~/.emacs.d/lisp/paren.el")

(setopt use-short-answers t)

;; 启动守护进程
(use-package server
  :config
  (unless (server-running-p)
    (server-start)))

;; 终端复制
;; 检查是否为 macOS
(unless (eq system-type 'darwin)
  (use-package xclip
    :ensure t
    :config
    ;; 在这里添加 xclip 的配置
    (xclip-mode 1)))
(when (eq system-type 'darwin)  ;; 检查是否为 macOS
  (use-package osx-clipboard
    :ensure t
    :config
    (osx-clipboard-mode 1))
)
