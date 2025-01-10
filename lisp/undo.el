;; (use-package undo-fu)
;; (use-package undo-fu-session
;;  )
;; (undo-fu-session-global-mode)
;; (setq undo-fu-session-directory "/tmp/")

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1))
