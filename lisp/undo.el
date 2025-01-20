(use-package undo-fu)
(use-package undo-fu-session
  :config
  (undo-fu-session-global-mode +1))
(use-package vundo
  :config
  (with-eval-after-load 'meow
    (meow-leader-define-key
     '("u" . vundo))))
