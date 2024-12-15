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
;(progn
;  (vertico-mode 'toggle)
;  (marginalia-mode 'toggle))
(vertico-mode 1)
(marginalia-mode 1)
