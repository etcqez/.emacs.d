;; Enable ligatures (Emacs 28+)
(use-package ligature
  :ensure t
  :config
  (ligature-set-ligatures 't '("www" "->" "=>" "::" ":=" "<=" ">=" "!=" "===" "!=="))
  (global-ligature-mode t))

;; ;; 1. 英文字体（13px）
;; (set-face-attribute 'default nil
;;                     :font "FiraCode Nerd Font"
;;                     :===height 130)

;; ;; 2. 中文字体（12px）
;; ;; 只能使用 face 控制大小，不能用 set-fontset-font 的 :height。
;; ;; 所以我们先告诉 Emacs 用 Sarasa：
;; (dolist (charset '(kana han cjk-misc bopomofo symbol))
;;   (set-fontset-font t charset
;;                     (font-spec :family "Sarasa Mono SC")))

;; ;; 然后真正设置中文大小：通过 fixed-pitch 让 CJK 用 12px
;; (set-face-attribute 'fixed-pitch nil
;;                     :font "Sarasa Mono SC"
;;                     :height 120)

;; ;; 让 CJK 继承 fixed-pitch
;; (setq face-font-rescale-alist
;;       '(("Sarasa Mono SC" . 0.95)))  ;; 12/13 ≈ 0.92










;; ============================================================
;; JetBrainsMono (修正版) + Sarasa Term SC
;; ============================================================

(defun font-exists-p (font) (if (null (x-list-fonts font)) nil t))
(defun get-valid-font (fonts) (cl-find-if #'font-exists-p fonts))

;; 1. 这里的名字完全照抄你的 fc-list 输出
;; 优先用 "JetBrainsMono NFM" (Nerd Font Mono)，它是专门给代码编辑器用的
;; 如果没找到，再用 "JetBrainsMono Nerd Font"
(defvar my-en-font-list '("JetBrainsMono Nerd Font Mono"  ; 你的列表里有这个
                          "JetBrainsMono NFM"             ; 简写版
                          "JetBrainsMono Nerd Font"       ; 标准版 (无空格!)
                          "Monospace"))

;; 2. 中文用 Sarasa Term SC (紧凑版)
(defvar my-cn-font-list '("Sarasa Term SC" 
                          "Sarasa Mono SC"
                          "WenQuanYi Micro Hei"))

(defvar current-en-font (get-valid-font my-en-font-list))
(defvar current-cn-font (get-valid-font my-cn-font-list))

(if (and current-en-font current-cn-font)
    (progn
      ;; --------------------------------------------------------
      ;; 行间距设置
      ;; JetBrains 比较高，0.15 配合它非常舒服，既不抖动也不太稀疏
      ;; --------------------------------------------------------
      (setq-default line-spacing 0.15)

      ;; 设置英文 (12pt)
      (set-face-attribute 'default nil
                          :font current-en-font
                          :height 120)

      ;; 设置 fixed-pitch
      (set-face-attribute 'fixed-pitch nil
                          :font current-en-font
                          :height 120)

      ;; 设置中文映射
      (dolist (charset '(kana han cjk-misc bopomofo symbol))
        (set-fontset-font t charset (font-spec :family current-cn-font)))

      ;; --------------------------------------------------------
      ;; 完美缩放比例
      ;; JetBrainsMono 和 Sarasa Term 高度是绝配。
      ;; 0.90 是黄金比例，既能完美对其基线，又不会撑大行高。
      ;; --------------------------------------------------------
      (setq face-font-rescale-alist nil)
      (add-to-list 'face-font-rescale-alist (cons current-cn-font 0.90))

      (message "加载成功: [%s] + [%s]" current-en-font current-cn-font))

  (message "失败: 依然没找到字体，请确认 fc-cache -fv 已运行"))
