(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (company-mode -1))) ; 禁用 company-mode
