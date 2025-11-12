(use-package nerd-icons)
(use-package nerd-icons-completion
  :hook (after-init . nerd-icons-completion-mode))
(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

;; (use-package powerline
;;   :ensure t
;;   :config
;;   ;; (powerline-center-evil-theme)
;;   )
;; (use-package airline-themes
;;   :ensure t
;;   :config
;;   )



(use-package nyan-mode
  :init
  (setq nyan-bar-length 20)
  (setq nyan-minimum-window-width 0)
  (nyan-mode +1))

;; (use-package catppuccin-theme
;;   :ensure t
;;   :config
;;       (load-theme 'catppuccin :no-confirm)
;;       (load-theme 'airline-doom-one t)
;;       )


(use-package doom-modeline
  :ensure t
  :config
  (setq doom-modeline-percent-position nil)
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-window-width-limit nil)

  :init (doom-modeline-mode 1))
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; emacs让帮助窗口出现在minibuffer上面
(setq display-buffer-alist
      '(("*Help*" . ((display-buffer-at-bottom) (window-height . 10)))))

(setq ring-bell-function 'ignore)

