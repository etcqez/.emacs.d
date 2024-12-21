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
