(use-package avy
  :ensure t
  :config

  (set-face-attribute 'avy-lead-face nil :foreground "black" :background "deeppink")
  (set-face-attribute 'avy-lead-face-0 nil :foreground "black" :background "deeppink")
  (set-face-attribute 'avy-lead-face-1 nil :foreground "black" :background "deeppink")
  (set-face-attribute 'avy-lead-face-2 nil :foreground "black" :background "deeppink")
  (set-face-attribute 'avy-goto-char-timer-face nil :foreground "black" :background "green")

  (setq avy-background t)
  (setq avy-keys (number-sequence ?a ?z))
  (setq avy-all-windows t)
  )
