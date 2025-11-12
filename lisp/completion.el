;; (use-package company
;;   :demand t
;;   :config
;;   (add-hook 'after-init-hook 'global-company-mode)
;;   (setq company-dabbrev-ignore-case nil)  ; 禁用忽略大小写
;;   (setq company-dabbrev-downcase nil)     ; 禁用自动转小写
;;   (setq company-minimum-prefix-length 1)  ; 输入 1 个字符即触发补全
;;   (setq company-idle-delay 0)  ; 输入后立即触发，无延迟
;;   (setq company-frontends '(company-pseudo-tooltip-frontend))  ; 仅保留工具提示
;;   (setq company-allow-wrap t)  ; 允许候选菜单循环选择
;;   (setq vertico-cycle t)  ; vertico 的循环选择
;;   )
;; (use-package corfu
;;   :ensure t
;;   :init
;;   (global-corfu-mode)
;;   (setq corfu-auto t)  ;; 自动补全
;;   (setq corfu-quit-at-boundary t)  ;; 在边界退出补全
;;   )

;; TAB-only configuration
(use-package corfu
  :custom
  (corfu-auto t)               ;; Enable auto completion
  (corfu-preselect 'directory) ;; Select the first candidate, except for directories

  :init
  (global-corfu-mode)

  :config
  (keymap-unset corfu-map "RET")
)

(use-package cape
  :ensure t
  :init
  ;; 添加到全局补全后端
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  :config
  ;; Cape 特定配置
  (setq cape-dabbrev-min-length 3      ; 最小补全长度
        cape-dictionary-word-list nil  ; 不使用字典
        cape-dabbrev-check-other-buffers t)) ; 检查其他buffer

;; 配置补全后端 - 这是关键！
(use-package emacs
  :init
  ;; 设置 completion-at-point-functions
  (setq completion-at-point-functions
        '(cape-dabbrev        ; 当前buffer的单词补全
          cape-file           ; 文件路径补全
          cape-keyword        ; 关键字补全
          cape-abbrev         ; 缩写补全
          cape-symbol         ; Elisp符号补全
          cape-line           ; 当前行补全
          )))


;; (use-package lsp-mode
;;   :ensure t
;;   :init
;;   (setq lsp-auto-guess-root t)  ;; 自动猜测项目根目录
;;   (setq lsp-idle-delay 0.2)  ;; 补全触发延迟
;;   :hook
;;   ((python-mode . lsp)
;;    (java-mode . lsp)
;;    (go-mode . lsp)))
;; (add-hook 'prog-mode-hook 'lsp)
