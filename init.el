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

(ignore-errors
  
  (load "~/.emacs.d/lisp/basic.el")
  (load "~/.emacs.d/lisp/smartparens.el")
  (load "~/.emacs.d/lisp/avy.el")
  (load "~/.emacs.d/lisp/buffer.el")
  (load "~/.emacs.d/lisp/ace-window.el")
  (load "~/.emacs.d/lisp/undo.el")
  (load "~/.emacs.d/lisp/font.el")
  (load "~/.emacs.d/lisp/dashboard.el")
  (load "~/.emacs.d/lisp/icon.el")
  (load "~/.emacs.d/lisp/surround.el")

  (load "~/.emacs.d/lisp/meow.el")
  (load "~/.emacs.d/lisp/meow_customize.el")
  (load "~/.emacs.d/lisp/theme.el")
  (load "~/.emacs.d/lisp/color.el")

  (load "~/.emacs.d/lisp/vertico.el")
  (load "~/.emacs.d/lisp/corfu.el")
  (load "~/.emacs.d/lisp/keybindings.el")
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
  ;; (load "~/.emacs.d/lisp/daemon.el")
  ;; (load "~/.emacs.d/lisp/isearch.el")
  ;; (load "~/.emacs.d/lisp/xml.el")
  
  )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-fold-catch-invisible-edits 'show-and-error nil nil "Customized with use-package org-modern")
 '(package-selected-packages nil))
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
 '(avy-lead-face-2 ((t (:foreground "red" :background unspecified)))))
