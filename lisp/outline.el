(use-package outline
  :ensure nil
  :bind
  ;; ("<f10>" . outline-minor-mode)
  :config
  (setq outline-minor-mode-highlight nil) ; emacs28
  (setq outline-minor-mode-cycle t) ; emacs28
  (setq outline-minor-mode-use-buttons nil) ; emacs29---bless you for the nil option!
  (setq outline-minor-mode-use-margins nil)
) ; as above
(defun global-outline-minor-mode (&optional arg)
  "全局启用或禁用 outline-minor-mode"
  (interactive)
  (if (or (and (null arg) (not outline-minor-mode))
          (>= (prefix-numeric-value arg) 0))
      (progn
        (add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)
    (remove-hook 'prog-mode-hook 'outline-minor-mode)
    (remove-hook 'text-mode-hook 'outline-minor-mode)
    (remove-hook 'org-mode-hook 'outline-minor-mode)
    )))

;; 启用全局 outline-minor-mode
(global-outline-minor-mode 1)
