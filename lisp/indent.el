;; (use-package indent-guide
;;   :ensure t
;;   :config
;;   (indent-guide-global-mode t)
;; )					;
(use-package indent-bars
  :ensure t
  :hook (prog-mode . indent-bars-mode) ; 在所有编程模式中开启
  :config
  ;; 默认 blend 可能是 0.1，尝试调大到 0.3 或 0.4
  ;; :face-bg t 表示使用背景色混合，:blend 是混合比例
  (setq indent-bars-color '(highlight :face-bg t :blend 0.5))
)

