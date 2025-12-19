;; Enable ligatures (Emacs 28+)
(use-package ligature
  :ensure t
  :config
  (ligature-set-ligatures 't '("www" "->" "=>" "::" ":=" "<=" ">=" "!=" "===" "!=="))
  (global-ligature-mode t))

;; ============================================================
;; 1. 修复辅助函数：防止在终端下调用 x-list-fonts 导致崩溃
;; ============================================================
(defun font-exists-p (font) 
  "Check if FONT exists. Returns nil if in terminal."
  (and (display-graphic-p)                 ;; 【关键修改】先检查是否是图形界面
       (not (null (x-list-fonts font)))))  ;; 然后才检查字体

(defun get-valid-font (fonts) (cl-find-if #'font-exists-p fonts))

;; ============================================================
;; 2. 字体列表定义 (保持你的原样)
;; ============================================================
(defvar my-en-font-list '("JetBrains Mono"
			  "JetBrainsMono Nerd Font Mono"
                          "JetBrainsMono NFM"
                          "JetBrainsMono Nerd Font"

                          "Monospace"))

(defvar my-cn-font-list '("Sarasa Term SC" 
                          "Sarasa Mono SC"
                          "WenQuanYi Micro Hei"))

;; ============================================================
;; 3. 获取字体与应用设置
;; ============================================================
;; 注意：如果在终端启动，font-exists-p 会返回 nil，这里变量也会是 nil，但这没关系
(defvar current-en-font (get-valid-font my-en-font-list))
(defvar current-cn-font (get-valid-font my-cn-font-list))

;; 【关键修改】在应用设置前，再次确认是否在 GUI 下且找到了字体
(if (and (display-graphic-p) current-en-font current-cn-font)
    (progn
      ;; --------------------------------------------------------
      ;; 行间距设置
      ;; --------------------------------------------------------
      (setq-default line-spacing 0.15)

      ;; 设置英文 (120 = 12pt)
      (set-face-attribute 'default nil
                          :font current-en-font
                          :height 110)

      ;; 设置 fixed-pitch
      (set-face-attribute 'fixed-pitch nil
                          :font current-en-font
                          :height 110)

      ;; 设置中文映射
      (dolist (charset '(kana han cjk-misc bopomofo symbol))
        (set-fontset-font t charset (font-spec :family current-cn-font)))

      ;; --------------------------------------------------------
      ;; 完美缩放比例
      ;; --------------------------------------------------------
      (setq face-font-rescale-alist nil)
      (add-to-list 'face-font-rescale-alist (cons current-cn-font 0.90))

      (message "字体加载成功: [%s] + [%s]" current-en-font current-cn-font))

  ;; 【关键修改】只有在图形界面下没找到字体才报错，终端下保持沉默
  (when (display-graphic-p)
    (message "失败: 未检测到指定字体，请确认 fc-cache -fv 已运行")))
