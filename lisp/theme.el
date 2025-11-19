;; 小猫
(use-package nyan-mode
  :init
  (setq nyan-bar-length 20)
  (setq nyan-minimum-window-width 0)
  (nyan-mode +1))


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
(setq ring-bell-function 'ignore)


;; (use-package airline-themes
;;   :ensure t
;;   :config
;;   )
;; (use-package catppuccin-theme
;;   :ensure t
;;   :config
;;       (load-theme 'catppuccin :no-confirm))
