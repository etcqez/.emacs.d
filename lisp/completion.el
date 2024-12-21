(use-package company
  :demand t
  :config
  ;(define-key evil-insert-state-map (kbd "C-x C-f") 'company-files)
  (add-hook 'after-init-hook 'global-company-mode)
  )
;(with-eval-after-load 'evil
;  (undo-fu-session-recover))

