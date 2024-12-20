  ;; v模式颜色
  (set-face-attribute 'region nil :background "royalblue")
  (set-face-attribute 'mouse-drag-and-drop-region nil :background "blue")
  ;; ;; 搜索颜色
  (set-face-attribute 'lazy-highlight nil :foreground "black" :background "green")
  (set-face-attribute 'isearch nil :foreground "black" :background "deeppink")
  ;; 括号颜色
  (set-face-attribute 'show-paren-match nil :foreground "DeepPink" :background "#00000000")
  ;; ;; vertico
  ;; (set-face-attribute 'vertico-current nil :foreground "black" :background "DarkSeaGreen3")
  ;; ;; marginalia
  ;; (set-face-attribute 'marginalia-documentation nil :foreground "dark red")
    ;; 行号
  (set-face-attribute 'line-number-current-line nil :foreground "white")
  (set-face-attribute 'line-number nil :foreground "gray60")

;; 光标颜色
(setq evil-default-cursor       '("DodgerBlue1" box)
      evil-normal-state-cursor  '("DeepPink" box)
      evil-emacs-state-cursor   '("orange" box)
      evil-motion-state-cursor  '("SeaGreen1" box)
      evil-insert-state-cursor  '("white" bar)
      evil-visual-state-cursor  '("white" bar)
      evil-replace-state-cursor '("pink" box))
(setopt use-short-answers t)
