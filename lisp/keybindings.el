(define-key evil-normal-state-map (kbd "C-x C-b") 'switch-to-buffer)

;; vim 窗口导航
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

;; mark
(define-key evil-normal-state-map (kbd "S-SPC") 'set-mark-command)

;; 退格键一次删除一个路径的分隔符（比如 /）


(define-key evil-normal-state-map (kbd "0") 'evil-first-non-blank)

(add-hook 'minibuffer-setup-hook
          (lambda ()
            (define-key minibuffer-local-map (kbd "M-m") 'set-mark-command)))
