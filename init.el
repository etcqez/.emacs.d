;; clm/open-command-log-buffer C-c o
;; evll C-c C-e

(setq inhibit-startup-message t)
(global-display-line-numbers-mode 1)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

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

(use-package command-log-mode
  :config (command-log-mode 1))

(use-package avy
  :ensure t
  :config)


(with-eval-after-load 'cnfonts
  (set-face-attribute 'default nil :font "Hack")
  )

;; lsp
(use-package lsp-mode
  :ensure t
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :config (setq lsp-completion-enable-additional-text-edit nil))
(use-package lsp-ui
  :commands lsp-ui-mode
  :ensure t)
(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))
(use-package flycheck
  :ensure t)
(use-package yasnippet
  :ensure t
  :config (yas-global-mode))
;;; This will enable emacs to compile a simple cpp single file without any makefile by just pressing [f9] key
(defun code-compile()
  (interactive)
  (unless (file-exists-p "Makefile")
    (set (make-local-variable 'compile-command)
	 (let ((file (file-name-nondirectory buffer-file-name)))
	   (format "%s -o %s %s"
		   (if (equal (file-name-extension file) "cpp") "g++" "gcc")
		   (file-name-sans-extension file)
		   file)))
    (compile compile-command)))
(global-set-key [f9] 'code-compile)


;; 中文输入法
(use-package pyim
  :config
  (setq default-input-method "pyim")
  (pyim-default-scheme 'wubi)
  (pyim-isearch-mode 1)
  (setq pyim-cloudim 'baidu)
  ;; (setq pyim-cloudim 'google)
  )
(use-package pyim-wbdict
  :config
  (pyim-wbdict-v86-enable) ;86版五笔用户使用这个命令
  )
(use-package popup
  :config
  (setq pyim-page-tooltip 'popup)
  )
(use-package cnfonts
  :config
  (cnfonts-mode 1)
  (define-key cnfonts-mode-map (kbd "C--") #'cnfonts-decrease-fontsize)
  (define-key cnfonts-mode-map (kbd "C-=") #'cnfonts-increase-fontsize)
  )


;;; Vim Bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  ;; (setq evil-undo-system 'undo-fu)
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-fu)
  )
;;
(use-package evil-commentary
  :demand t
  :config
  (evil-commentary-mode)
  (define-key evil-motion-state-map (kbd "g c") 'evil-commentary-line)
  )
;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))


(use-package vertico
  :ensure t
  :config
  (setq vertico-cycle t)
  (setq vertico-resize nil)
  (vertico-mode 1)
  )
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))
(progn
  (vertico-mode 'toggle)
  (marginalia-mode 'toggle))
(vertico-mode 1)
(marginalia-mode 1)


(save-place-mode 1)

(global-set-key "\C-x\C-\\" 'goto-last-change)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; (load custom-file)

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))

(use-package consult
  :ensure t
  :bind (;; A recursive grep
         ("M-s M-g" . consult-grep)
         ;; Search for files names recursively
         ("M-s M-f" . consult-find)
         ;; Search through the outline (headings) of the file
         ("M-s M-o" . consult-outline)
         ;; Search the current buffer
         ("M-s M-l" . consult-line)
         ;; Switch to another buffer, or bookmarked file, or recently
         ;; opened file.
         ("M-s M-b" . consult-buffer)))

(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
         :map minibuffer-local-map
         ("C-c C-c" . embark-collect)
         ("C-c C-e" . embark-export)))

;; The `embark-consult' package is glue code to tie together `embark'
;; and `consult'.
(use-package embark-consult
  :ensure t)

(use-package undo-tree
  :demand t
  :config
  (global-undo-tree-mode)
  )

(use-package undo-fu
  :demand t
  :config
  ;; (with-eval-after-load 'evil
  ;;   (setq evil-undo-system 'undo-fu))
  (undo-fu-session-recover)
  )

;;

(use-package undo-fu-session
  :demand t
  :config
  (undo-fu-session-global-mode)
  )

(use-package company
  :demand t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  )
(with-eval-after-load 'evil
  (undo-fu-session-recover))

(use-package evil-numbers
  :demand t
  )

(use-package rainbow-mode
  :demand t
  :config
  (rainbow-mode)
  )

(recentf-mode 1)
(savehist-mode 1)
(desktop-save-mode 1)
(setq display-buffer-alist
      '(
        ("\\*shell\\*"
	 (display-buffer-in-side-window)
	 (side . right)
         ;; (dedicated . t)
         ;; (window-height . fit-window-to-buffer)
	 )
        ("\\*eshell\\*"
	 (display-buffer-in-side-window)
	 (side . right)
	 )
        ("\\*terminal\\*"
	 (display-buffer-in-side-window)
	 (side . right)
	 )
        ("\\*ansi\-term\\*"
	 (display-buffer-in-side-window)
	 (side . right)
	 )
	))

(define-abbrev global-abbrev-table "metest" "a global abbrev for demo purposes")
(define-abbrev text-mode-abbrev-table "metest" "text-mode abbrev expansion here")
;; `abbrev-mode' is buffer-local
(abbrev-mode 1) ; so this is WRONG
(add-hook 'text-mode-hook 'abbrev-mode)



;; vim
(with-eval-after-load 'evil
  (define-key evil-motion-state-map (kbd "0") 'evil-first-non-blank)
  )
(defun phg/kill-to-bol ()
  "Kill from point to beginning of line."
  (interactive)
  (kill-line 0))
(define-key evil-insert-state-map (kbd "C-u") 'phg/kill-to-bol)
;; vim-numbers
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-e") 'evil-numbers/dec-at-pt)
(define-key evil-normal-state-map (kbd "=") 'lsp-format-buffer)
(define-key evil-normal-state-map (kbd "+") 'format-all-buffer)
;; (define-key evil-normal-state-map (kbd "C-t") 'treemacs-display-current-project-exclusively)
;; scrolloff
(setq scroll-step 1)
(setq scroll-margin 5)
(setq scroll-conservatively 9999)

;; emacs
(define-key evil-insert-state-map (kbd "C-e") #'end-of-line)
(define-key evil-insert-state-map (kbd "C-a") #'evil-insert-line)
(define-key evil-insert-state-map (kbd "C-k") #'kill-line)

(define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)
(define-key evil-insert-state-map (kbd "C-d") #'evil-paste-last-insertion)

;; C-s
(defun save-with-normal (number)       ; Interactive version.
  (interactive "p")
  (save-buffer)
  (evil-normal-state))
(define-key global-map (kbd "C-s") 'save-with-normal)

(define-key evil-insert-state-map (kbd "C-n") #'next-line)
(define-key evil-insert-state-map (kbd "C-p") #'previous-line)
(define-key evil-insert-state-map (kbd "C-t") #'transpose-chars)
(define-key evil-normal-state-map (kbd "<tab>") #'evil-shift-right)
(define-key evil-normal-state-map (kbd "s") #'avy-goto-char-timer)
(define-key evil-insert-state-map (kbd "C-y") #'yank)
(define-key evil-normal-state-map (kbd "u") #'undo-tree-undo)
(define-key evil-normal-state-map (kbd "C-r") #'undo-tree-redo)

;; s
(setq avy-background t)
(setq avy-keys (number-sequence ?a ?z))
(setq avy-all-windows t)

;; python
(setq org-babel-python-command "python3")

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))


(with-eval-after-load 'org
  (define-key evil-motion-state-map (kbd "C-d") #'evil-forward-paragraph)
  )

;; (setq auto-save-file-name-transforms
;;   `((".*" "~/.emacs-saves/" t)))
(electric-pair-mode t)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; 切换最近buffer
(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))
(global-set-key (kbd "C-<backspace>") 'switch-to-last-buffer)
(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-frame (before other-frame-now activate)
  (when buffer-file-name (save-buffer)))

(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=c"))
                  ("Shell" (shfmt "-i" "4" "-ci")))))

;; 在treemacs中, 使用emacs键绑定
(evil-set-initial-state 'treemacs-mode 'emacs)

;; 禁用光标闪烁
(blink-cursor-mode 0)

;; 光标颜色
(setq evil-default-cursor       '("DodgerBlue1" box)
      evil-normal-state-cursor  '("DeepPink" box)
      evil-emacs-state-cursor   '("orange" box)
      evil-motion-state-cursor  '("SeaGreen1" box)
      evil-insert-state-cursor  '("white" bar)
      evil-visual-state-cursor  '("white" bar)
      evil-replace-state-cursor '("pink" box))
(setopt use-short-answers t)

(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t)
  ;; v模式颜色
  (set-face-attribute 'region nil :background "SpringGreen4")
  (set-face-attribute 'mouse-drag-and-drop-region nil :background "#be369c")
  (set-face-attribute 'mode-line nil :foreground "FloralWhite" :background "PaleVioletRed4")
  ;; 搜索颜色
  (set-face-attribute 'lazy-highlight nil :foreground "black" :background "DarkOliveGreen3")
  (set-face-attribute 'isearch nil :foreground "black" :background "red")
  ;; 括号颜色
  (set-face-attribute 'show-paren-match nil :foreground "DeepPink" :background "#00000000")
  ;; vertico
  (set-face-attribute 'vertico-current nil :foreground "black" :background "DarkSeaGreen3")
  ;; marginalia
  (set-face-attribute 'marginalia-documentation nil :foreground "dark red")
  ;; avy
  (set-face-attribute 'avy-goto-char-timer-face nil :foreground "black" :background "aquamarine4")
  (set-face-attribute 'avy-lead-face nil :foreground "black" :background "OrangeRed4")
  (set-face-attribute 'avy-lead-face-0 nil :foreground "black" :background "OrangeRed4")
  (set-face-attribute 'avy-lead-face-1 nil :foreground "black" :background "OrangeRed4")
  (set-face-attribute 'avy-lead-face-2 nil :foreground "black" :background "OrangeRed4")
  ;; 行号
  (set-face-attribute 'line-number-current-line nil :foreground "CadetBlue1")
  )
(use-package treemacs
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "C-t") 'treemacs)
  (define-key evil-emacs-state-map (kbd "C-t") 'treemacs)
  )
    
