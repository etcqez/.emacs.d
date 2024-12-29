;; 切换最近buffer
(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))
;(define-key evil-normal-state-map (kbd "SPC TAB") 'switch-to-last-buffer)
(defadvice switch-to-buffer (before save-buffer-now activate)
           (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
           (when buffer-file-name (save-buffer)))
(defadvice other-frame (before other-frame-now activate)
           (when buffer-file-name (save-buffer)))

(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=c"))
                  ("Shell" (shfmt "-i" "4" "-ci")))))

;; mark
;; (add-hook 'minibuffer-setup-hook
;;           (lambda ()
;;             (define-key minibuffer-local-map (kbd "C-'") 'set-mark-command)))
;; (define-key global-map (kbd "C-'") 'set-mark-command)
;; (defun phg/kill-to-bol ()
;;   "Kill from point to beginning of line."
;;   (interactive)
;;   (kill-line 0))
;; (define-key evil-insert-state-map (kbd "C-u") 'phg/kill-to-bol)
(define-key global-map (kbd "M-<insert>") 'yank)
