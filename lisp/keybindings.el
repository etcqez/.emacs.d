;; 将物理键翻译为标准的 Emacs 组合键
(define-key key-translation-map (kbd "<up>") (kbd "C-p"))
(define-key key-translation-map (kbd "<down>") (kbd "C-n"))
(define-key key-translation-map (kbd "<left>") (kbd "C-b"))
(define-key key-translation-map (kbd "<right>") (kbd "C-f"))
(define-key key-translation-map (kbd "<home>") (kbd "C-a"))
(define-key key-translation-map (kbd "<end>") (kbd "C-e"))

;; (global-set-key (kbd "C-x <right>") 'find-file)
;; (global-set-key (kbd "C-f") 'find-file)
;; (define-key meow-insert-state-keymap (kbd "C-x C-f") 'company-files)
(define-key meow-insert-state-keymap (kbd "C-g") 'meow-insert-exit)
(define-key meow-insert-state-keymap (kbd "<escape>") 'meow-normal-mode)
(global-set-key (kbd "<backspace>")
                (lambda ()
                  (interactive)
                  (if (region-active-p)
                      (delete-active-region)
                    (backward-delete-char 1))))

(defun delete-active-region ()
  "删除激活的选区。"
  (interactive)
  (when (region-active-p)
    (delete-region (region-beginning) (region-end))))

;; (define-key meow-normal-state-keymap (kbd "C-f") 'scroll-up-command)
;; (define-key meow-normal-state-keymap (kbd "C-b") 'scroll-down-command)
;; (define-key meow-normal-state-keymap (kbd "C-k") 'meow-kill)

;; (with-eval-after-load 'dashboard
;;   (define-key dashboard-mode-map (kbd "q") 'save-buffers-kill-terminal)
;;   )
(global-set-key (kbd "C-s-f") 'toggle-frame-fullscreen)
;; (global-set-key (kbd "C-k") 'meow-kill)
(global-set-key (kbd "C-w") 'meow-clipboard-save)(global-set-key (kbd "C-w") 'meow-clipboard-save)
(global-set-key (kbd "C-y") 'clipboard-yank)

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
;; (defun my/safe-yank ()
;;   "精确复制到 kill-ring 且不影响系统剪贴板，仅在整行复制时添加空行并定位"
;;   (interactive)
;;   (when (use-region-p)
;;     (let* ((beg (region-beginning))
;;            (end (region-end))
;;            (is-whole-line (and (save-excursion (goto-char beg) (bolp))
;;                               (save-excursion (goto-char end) (or (eolp) (eobp)))))
;;            (text (buffer-substring-no-properties beg end))
;;            (copied-text (if is-whole-line
;;                             (concat text "\n")  ;; 仅在整行复制时添加换行符
;;                           text))
;;            ;; 完全禁用剪贴板交互
;;            (select-enable-clipboard nil)
;;            (interprogram-cut-function nil))
      
;;       ;; 安全复制到 kill-ring
;;       (kill-new copied-text)
;;       (deactivate-mark)
      
;;       ;; 仅在整行复制时移动光标
;;       (when is-whole-line
;;         (goto-char end)
;;         (if (eobp)
;;             (progn  ; 文件末尾处理
;;               (end-of-line)
;;               (newline)
;;               (beginning-of-line))
;;           (progn  ; 正常定位到下一行行首
;;             (forward-line 1)
;;             (beginning-of-line)))))))

(defun my/safe-yank ()
  "精确复制到 kill-ring 且不影响系统剪贴板，在整行复制时添加空行并定位"
  (interactive)
  (when (use-region-p)
    (let* ((beg (region-beginning))
           (end (region-end))
           ;; 检查选区是否从行首开始
           (beg-at-bol (save-excursion (goto-char beg) (bolp)))
           ;; 检查选区是否在行尾结束
           (end-at-eol (save-excursion (goto-char end) (or (eolp) (eobp))))
           (text (buffer-substring-no-properties beg end))
           ;; 仅在选区是整行时添加换行符
           (copied-text (if (and beg-at-bol end-at-eol)
                            (concat text "\n")
                          text))
           ;; 完全禁用剪贴板交互
           (select-enable-clipboard nil)
           (interprogram-cut-function nil))
      
      ;; 安全复制到 kill-ring
      (kill-new copied-text)
      (deactivate-mark)
      
      ;; 仅在整行复制时移动光标
      (when (and beg-at-bol end-at-eol)
        (goto-char end)
        (cond
         ;; 处理文件末尾情况
         ((eobp)
          (end-of-line)
          (unless (bolp) (newline))  ; 只在没有换行符时添加
          (beginning-of-line))
         
         ;; 正常情况：移动到下一行行首
         (t
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
   ;; '("M-w" . meow-clipboard-save) ; 只操作系统剪贴板
   ;; '("M-w" . my/safe-copy-to-clipboard) ; 只操作系统剪贴板
   ))

(defun kill-to-beginning-of-line ()
  "删除从光标到行首的内容"
  (interactive)
  (kill-region (point) (line-beginning-position)))

;; 绑定快捷键
(global-set-key (kbd "C-u") 'kill-to-beginning-of-line)

;; (defun avy-select-between-lines ()
;;   "使用 avy 快速选择两个行号之间的内容"
;;   (interactive)
;;   (let (start-line end-line)
;;     ;; 选择起始行
;;     (setq start-line (line-number-at-pos (avy-goto-line)))
;;     ;; 选择结束行  
;;     (setq end-line (line-number-at-pos (avy-goto-line)))
;;     ;; 选中区域
;;     (goto-line (min start-line end-line))
;;     (set-mark (point))
;;     (goto-line (max start-line end-line))
;;     (end-of-line)
;;     (exchange-point-and-mark)))

;; ;; 绑定快捷键
;; (global-set-key (kbd "C-c S") 'avy-select-between-lines)
