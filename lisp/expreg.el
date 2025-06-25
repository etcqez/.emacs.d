(use-package expreg
  :config
  (with-eval-after-load 'meow
    (meow-leader-define-key
     '("v" . expreg-expand))))
