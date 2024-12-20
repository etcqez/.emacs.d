;; clm/open-command-log-buffer C-c o
;; evll C-c C-e

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
(require 'use-package)
(setq use-package-always-ensure t)














;; 优先加载 my-priority-file.el
(load "~/.emacs.d/lisp/priority-file.el")

;; 然后加载其他 .el 文件
(dolist (file (directory-files "~/.emacs.d/lisp/" t "\\.el$"))
  (unless (string= file "~/.emacs.d/lisp/priority-file.el")
    (load file)))






(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil-surround evil-collection evil-commentary evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
