;; test
;;; Vim Bindings
;(use-package evil
;  :demand t
;  ;; :bind (
;  ;; ("<escape>" . evil-force-normal-state)
;  ;; )
;  :init
;  (setq evil-undo-system 'undo-fu)
;  (setq evil-want-keybinding nil)
;  :config
;  (evil-mode 1)
;  )
;
;
;(use-package evil-commentary
;  :demand t
;  :config
;  (evil-commentary-mode)
;  (define-key evil-motion-state-map (kbd "g c") 'evil-commentary-line)
;  )
;
;(use-package evil-collection
;  :after evil
;  :config

					;  (setq evil-want-integration t)
;  (evil-collection-init))
;
;(use-package evil-surround
;  :ensure t
;  :config
;  (global-evil-surround-mode 1))
;
;
;(use-package evil-numbers
;  :ensure t
;  :config
;  (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
;  (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
;  )

;; 光标颜色
;(setq evil-default-cursor       '("DodgerBlue1" box)
;      evil-normal-state-cursor  '("DeepPink" box)
;      evil-emacs-state-cursor   '("orange" box)
;      evil-motion-state-cursor  '("SeaGreen1" box)
;      evil-insert-state-cursor  '("white" bar)
;      evil-visual-state-cursor  '("white" bar)
;      evil-replace-state-cursor '("pink" box))
;(setopt use-short-answers t)

