;; font
;; English font
(set-face-attribute 'default nil
  :font "FiraCode Nerd Font"
  ;; :style "Regular"
  :height 130)

;; Enable ligatures (Emacs 28+)
(use-package ligature
  :ensure t
  :config
  (ligature-set-ligatures 't '("www" "->" "=>" "::" ":=" "<=" ">=" "!=" "===" "!=="))
  (global-ligature-mode t))

;; ;; 默认英文字体
;; (set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 130)

;; ;; 中文字体和英文保持一致高度
;; (dolist (charset '(kana han cjk-misc bopomofo))
;;   (set-fontset-font t charset
;;                     (font-spec :family "Sarasa Mono SC" :height 120)))

;; (set-face-attribute 'default nil :font "Sarasa Mono SC" :height 145)

;; (setq-default line-spacing 0.4)

;; 1. 英文字体（13px）
(set-face-attribute 'default nil
                    :font "FiraCode Nerd Font"
                    :height 130)

;; 2. 中文字体（12px）
;; 只能使用 face 控制大小，不能用 set-fontset-font 的 :height。
;; 所以我们先告诉 Emacs 用 Sarasa：
(dolist (charset '(kana han cjk-misc bopomofo symbol))
  (set-fontset-font t charset
                    (font-spec :family "Sarasa Mono SC")))

;; 然后真正设置中文大小：通过 fixed-pitch 让 CJK 用 12px
(set-face-attribute 'fixed-pitch nil
                    :font "Sarasa Mono SC"
                    :height 120)

;; 让 CJK 继承 fixed-pitch
(setq face-font-rescale-alist
      '(("Sarasa Mono SC" . 0.95)))  ;; 12/13 ≈ 0.92
