(define-key evil-normal-state-map (kbd "C-x C-b") 'switch-to-buffer)

;; mark
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (define-key minibuffer-local-map (kbd "M-m") 'set-mark-command)))

;; vim
(with-eval-after-load 'evil
  (define-key evil-motion-state-map (kbd "0") 'evil-first-non-blank)
  )
(defun phg/kill-to-bol ()
  "Kill from point to beginning of line."
  (interactive)
  (kill-line 0))
(define-key evil-insert-state-map (kbd "C-u") 'phg/kill-to-bol)
(define-key evil-normal-state-map (kbd "=") 'format-all-buffer)
(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=c"))
                  ("Shell" (shfmt "-i" "4" "-ci")))))

;; emacs
(define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
(define-key evil-insert-state-map (kbd "C-a") 'evil-insert-line)
(define-key evil-insert-state-map (kbd "C-k") 'kill-line)
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
(define-key evil-insert-state-map (kbd "C-d") 'delete-char)
(define-key evil-insert-state-map (kbd "C-n") 'next-line)
(define-key evil-insert-state-map (kbd "C-p") 'previous-line)
(define-key evil-insert-state-map (kbd "C-t") 'transpose-chars)

;; 切换最近buffer
(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))
(define-key evil-normal-state-map (kbd "SPC TAB") 'switch-to-last-buffer)
(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-frame (before other-frame-now activate)
  (when buffer-file-name (save-buffer)))
