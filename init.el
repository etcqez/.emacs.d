(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
;; \u6700\u5173\u952e\u7684\u662f\u4e0b\u9762\u8fd9\u4e00\u53e5\uff0c\u786e\u4fdd\u4e0e\u7cfb\u7edf\u526a\u8d34\u677f\u4ea4\u4e92\u65f6\u4f7f\u7528 utf-8
(setq selection-coding-system 'utf-8)

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
;; (when (eq system-type 'darwin)
;;   (load "~/.emacs.d/lisp/mac.el"))

(load "~/.emacs.d/lisp/basic.el")
(load "~/.emacs.d/lisp/sudo.el")
(load "~/.emacs.d/lisp/meow.el")
;; (load "~/.emacs.d/lisp/meow_customize.el")
(load "~/.emacs.d/lisp/keybindings.el")
(load "~/.emacs.d/lisp/parents.el")
(load "~/.emacs.d/lisp/avy.el")
(load "~/.emacs.d/lisp/buffer.el")
(load "~/.emacs.d/lisp/ace-window.el")
(load "~/.emacs.d/lisp/undo.el")
(load "~/.emacs.d/lisp/icon.el")
(load "~/.emacs.d/lisp/surround.el")
(load "~/.emacs.d/lisp/indent.el")

(load "~/.emacs.d/lisp/theme.el")
(load "~/.emacs.d/lisp/color.el")
(load "~/.emacs.d/lisp/font.el")

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
(load "~/.emacs.d/lisp/dashboard.el")
(load "~/.emacs.d/lisp/anki.el")
;; 图形界面
;; (when (display-graphic-p)
;;   (load "~/.emacs.d/graphic.el"))



;; (load "~/.emacs.d/lisp/projectile.el")
;; (load "~/.emacs.d/lisp/outline.el")

;; (load "~/.emacs.d/lisp/isearch.el")
;; (load "~/.emacs.d/lisp/xml.el")


;; 解决forfu报错
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gnus-group-news-low ((t nil)))
 '(gnus-group-news-low-empty ((t nil))))


;; ;; 1. C-z 分流：图形界面 undo，终端挂起
;; (defun my-smart-cz ()
;;   (interactive)
;;   (if (display-graphic-p) (undo) (suspend-frame)))

;; (global-set-key (kbd "C-z") #'my-smart-cz)
(global-set-key (kbd "C-z") #'undo)
(global-set-key (kbd "C-S-z") #'undo-redo)

;; 2. 焦点补丁：修正参数报错问题
(add-hook 'server-after-make-frame-hook (lambda () (select-frame-set-input-focus (selected-frame))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ace-window cape consult corfu corfu-terminal dashboard doom-modeline
		doom-themes expand-region expreg git-gutter
		goto-last-change indent-bars ligature meow neotree
		nyan-mode orderless rainbow-delimiters smartparens
		sudo-edit surround undo-fu undo-fu-session valign
		vertico vundo xclip)))
