(define-key meow-insert-state-keymap (kbd "C-x C-f") 'company-files)
(define-key meow-insert-state-keymap (kbd "C-g") 'meow-insert-exit)

;; (define-key meow-normal-state-keymap (kbd "C-f") 'scroll-up-command)
;; (define-key meow-normal-state-keymap (kbd "C-b") 'scroll-down-command)

;; (with-eval-after-load 'dashboard
;;   (define-key dashboard-mode-map (kbd "q") 'save-buffers-kill-terminal)
;;   )
(global-set-key (kbd "C-s-f") 'toggle-frame-fullscreen)

(add-hook 'dashboard-mode-hook
          (lambda ()
            ;; (define-key dashboard-mode-map (kbd "s") 'avy-goto-char-timer)
            ;; (define-key dashboard-mode-map (kbd "q") 'save-buffers-kill-terminal)
            ))


;; (global-set-key (kbd "C-c d") (lambda () (interactive) (switch-to-buffer "*dashboard*")))
;; (global-set-key (kbd "C-c s") (lambda () (interactive) (switch-to-buffer "*scratch*")))
