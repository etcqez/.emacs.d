(use-package avy
  :ensure t
  :config
  (custom-set-faces
   '(avy-background-face ((t (:background nil :foreground "gray60"))))
   '(avy-lead-face ((t (:foreground "red" :background nil))))
   '(avy-goto-char-timer-face ((t (:foreground "skyblue" :background nil))))
   '(avy-lead-face-0 ((t (:foreground "red" :background nil))))
   '(avy-lead-face-1 ((t (:foreground "red" :background nil))))
   '(avy-lead-face-2 ((t (:foreground "red" :background nil)))))
  (setq avy-background t)
  (setq avy-keys (number-sequence ?a ?z))
  (setq avy-all-windows t)
  )
