(setq gc-cons-percentage 0.2
      gc-cons-threshold (* 128 1024 1024))
(add-hook 'focus-out-hook #'garbage-collect)

(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook (lambda ()
			     (setq gc-cons-threshold 800000)))


(setq package-enable-at-startup nil)
(setq load-prefer-newer noninteractive)

;; Do not resize the frame at this early stage.
(setq frame-inhibit-implied-resize t)

;; System default coding
(set-language-environment 'utf-8)

;; Cleaner GUI
(unless (eq system-type 'darwin)
  (menu-bar-mode -1))

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;;; early-init.el ends here
(load-theme 'wombat)
