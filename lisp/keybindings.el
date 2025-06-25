(define-key meow-insert-state-keymap (kbd "C-x C-f") 'company-files)
(define-key meow-insert-state-keymap (kbd "C-g") 'meow-insert-exit)

;; (define-key meow-normal-state-keymap (kbd "C-f") 'scroll-up-command)
;; (define-key meow-normal-state-keymap (kbd "C-b") 'scroll-down-command)
;; (define-key meow-normal-state-keymap (kbd "C-k") 'meow-kill)

;; (with-eval-after-load 'dashboard
;;   (define-key dashboard-mode-map (kbd "q") 'save-buffers-kill-terminal)
;;   )
(global-set-key (kbd "C-s-f") 'toggle-frame-fullscreen)
;; (global-set-key (kbd "C-k") 'meow-kill)
;; (global-set-key (kbd "M-w") 'meow-clipboard-save)

(add-hook 'dashboard-mode-hook
          (lambda ()
            ;; (define-key dashboard-mode-map (kbd "s") 'avy-goto-char-timer)
            ;; (define-key dashboard-mode-map (kbd "q") 'save-buffers-kill-terminal)
            ))


;; (global-set-key (kbd "C-c d") (lambda () (interactive) (switch-to-buffer "*dashboard*")))
;; (global-set-key (kbd "C-c s") (lambda () (interactive) (switch-to-buffer "*scratch*")))
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c <tab>") 'org-metaright)
  (define-key org-mode-map (kbd "C-c S-<tab>") 'org-metaleft)
  (define-key org-mode-map (kbd "C-<return>") 'org-meta-return)
  (define-key org-mode-map (kbd "M-RET") 'org-insert-heading-respect-content)
  )




;; ;; 独立于 Meow 的复制系统
;; (defun my/yank-without-clipboard ()
;;   "仅复制到 kill-ring，不触及系统剪贴板"
;;   (interactive)
;;   (when (use-region-p)
;;     (let ((select-enable-clipboard nil)
;;           (text (buffer-substring-no-properties (region-beginning) (region-end))))
;;       (kill-new text)
;;       (deactivate-mark))))

;; (defun my/copy-to-clipboard ()
;;   "直接复制到系统剪贴板，不经过 kill-ring"
;;   (interactive)
;;   (when (use-region-p)
;;     (let ((text (buffer-substring-no-properties (region-beginning) (region-end))))
;;       (gui-set-selection 'CLIPBOARD text)
;;       (deactivate-mark))))

;; ;; 覆盖 Meow 的原始绑定
;; (with-eval-after-load 'meow
;;   ;; 完全替换 Meow 的保存命令
;;   (meow-normal-define-key
;;    '("y" . my/yank-without-clipboard)
;;    '("M-w" . my/copy-to-clipboard)
   
;;    ;; 可选：修复视觉选区消失问题
;;    '("v" . meow-visit))
  
;;   ;; 确保使用标准选区
;;   (setq meow-use-clipboard t)
;;   (setq meow-selection-command-fallback 'region))

;; 最终优化版复制功能
(defun my/safe-yank ()
  "精确复制到 kill-ring 且不影响系统剪贴板，仅在整行复制时添加空行并定位"
  (interactive)
  (when (use-region-p)
    (let* ((beg (region-beginning))
           (end (region-end))
           (is-whole-line (and (save-excursion (goto-char beg) (bolp))
                              (save-excursion (goto-char end) (or (eolp) (eobp)))))
           (text (buffer-substring-no-properties beg end))
           (copied-text (if is-whole-line
                            (concat text "\n")  ;; 仅在整行复制时添加换行符
                          text))
           ;; 完全禁用剪贴板交互
           (select-enable-clipboard nil)
           (interprogram-cut-function nil))
      
      ;; 安全复制到 kill-ring
      (kill-new copied-text)
      (deactivate-mark)
      
      ;; 仅在整行复制时移动光标
      (when is-whole-line
        (goto-char end)
        (if (eobp)
            (progn  ; 文件末尾处理
              (end-of-line)
              (newline)
              (beginning-of-line))
          (progn  ; 正常定位到下一行行首
            (forward-line 1)
            (beginning-of-line)))))))

;; 独立复制到系统剪贴板（不添加空行）
(defun my/safe-copy-to-clipboard ()
  "直接复制到系统剪贴板，不影响 kill-ring"
  (interactive)
  (when (use-region-p)
    (let ((text (buffer-substring-no-properties (region-beginning) (region-end))))
      (gui-set-selection 'CLIPBOARD text)
      (deactivate-mark)
      (message "已复制到系统剪贴板"))))

;; 配置 Meow 键位
(with-eval-after-load 'meow
  (meow-normal-define-key
   '("y" . my/safe-yank)           ; 只操作 kill-ring
   '("M-w" . meow-clipboard-save) ; 只操作系统剪贴板
   ;; '("M-w" . my/safe-copy-to-clipboard) ; 只操作系统剪贴板
   ))
