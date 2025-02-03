(define-key meow-insert-state-keymap (kbd "C-x C-f") 'company-files)
(define-key meow-insert-state-keymap (kbd "C-g") 'meow-insert-exit)

(with-eval-after-load 'dashboard
  (define-key dashboard-mode-map (kbd "q") 'save-buffers-kill-terminal)
  )
