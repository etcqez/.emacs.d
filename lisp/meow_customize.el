;; 自定义 d 键的行为
(defun my/meow-delete ()
  "如果有选区，删除选区内容；否则删除当前光标下的一个字符。"
  (interactive)
  (if (use-region-p) ; 检查是否有选区
      (meow-kill)    ; 删除选区内容
    (delete-char 1))) ; 仅删除一个字符
;; 绑定 d 键到自定义函数
(define-key meow-normal-state-keymap (kbd "d") 'my/meow-delete)

(defun my/meow-delete-to-end-of-line-and-insert ()
  "删除当前光标到行尾的内容，并进入插入模式。"
  (interactive)
  (let ((pos (point))) ; 保存当前光标位置
    (end-of-line) ; 移动光标到行尾
    (kill-region pos (point))) ; 删除从光标到行尾的内容
  (meow-insert-mode)) ; 进入插入模式

;; 绑定 C 键到自定义函数
(define-key meow-normal-state-keymap (kbd "C") 'my/meow-delete-to-end-of-line-and-insert)


;; 实现插入文本自动选中
(defun get-char-under-cursor ()
  "获取光标下的字符并显示在 minibuffer 中（交互式调用时）。
返回光标下的字符（作为整数），如果无字符则返回 nil。"
  (interactive)
  (let ((char (char-after (point))))
    (when (called-interactively-p 'interactive)
      (if char
          (message "字符: %c (Unicode: U+%04X)" char char)
        (message "光标处无字符")))
    char))  ; 返回字符值
(defun my-meow-change ()
  "插入原始光标下的字符到缓冲区"
  (interactive)
  ;; 如果有选中区域，先取消选中
  (when (region-active-p)
    (deactivate-mark))
  (let* ((orig-pos (point))  ; 保存原始位置
         (char (save-excursion  ; 在原始位置获取字符
                 (goto-char orig-pos)
                 (get-char-under-cursor))))
    (meow-change)  ; 执行 Meow 的 change 操作
    (if char
        (insert char)  ; 插入字符
      (insert ?\n)     ; 插入换行符
      (meow-insert-mode)
      ) ; 进入插入模式

    (backward-char 1)  ; 向后移动一格
    ))
(defun my-meow-append ()
  "插入原始光标下的字符到缓冲区"
  (interactive)
  ;; 如果有选中区域，先取消选中
  (when (region-active-p)
    (deactivate-mark))
  (meow-append)
  (meow-normal-mode)
  (my-meow-change)
  )
(define-key meow-normal-state-keymap (kbd "i") 'my-meow-change)
(define-key meow-normal-state-keymap (kbd "a") 'my-meow-change)


;; 自定义 o 键的行为
(defun my/insert-line-above ()
  "在当前行的上方插入一行，并进入插入模式。"
  (interactive)
  ;; 如果有选中区域，先取消选中
  (when (region-active-p)
    (deactivate-mark))

  (beginning-of-line)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode)
  (my-meow-change))

;; 自定义 O 键的行为
(defun my/insert-line-below ()
  "在当前行的下方插入一行，并进入插入模式。"
  (interactive)
  ;; 如果有选中区域，先取消选中
  (when (region-active-p)
    (deactivate-mark))

  (end-of-line)
  (newline-and-indent)
  (indent-according-to-mode)
  (my-meow-change))

;; 绑定 o 和 O 键
(define-key meow-normal-state-keymap (kbd "O") 'my/insert-line-above)
(define-key meow-normal-state-keymap (kbd "o") 'my/insert-line-below)

;; 自定义 I 键的行为
(defun my/move-to-beginning-and-insert ()
  "移动到行首第一个非空白字符后进入 meow 插入模式"
  (interactive)
  ;; 如果有选中区域，先取消选中
  (when (region-active-p)
    (deactivate-mark))
  (back-to-indentation)    ; 核心：直接使用内置函数跳到缩进位置
  ;; (deactivate-mark)        ; 确保取消选区
  (my-meow-change))  ; 安全调用 meow 插入模式



;; 自定义 A 键的行为
(defun my/move-to-end-and-insert ()
  "将光标移动到行尾并进入插入模式，取消选择区域。"
  (interactive)
  ;; 如果有选中区域，先取消选中
  (when (region-active-p)
    (deactivate-mark))
  (end-of-line) ; 移动到行尾
  ;; (deactivate-mark) ; 取消选择区域
  (my-meow-change)) ; 进入插入模式

;; 绑定 I 和 A 键
(define-key meow-normal-state-keymap (kbd "I") 'my/move-to-beginning-and-insert)
(define-key meow-normal-state-keymap (kbd "A") 'my/move-to-end-and-insert)


(defun my-yank-and-select ()
  "粘贴内容并激活选中区域。如果有活动选区，则替换选区内容。"
  (interactive)
  (if (use-region-p)  ; 检查是否有活动选区
      ;; 情况1: 有活动选区时替换内容
      (let ((start (region-beginning))
            (end (region-end)))
        (delete-region start end)))  ; 删除选区内容
  ;; 情况2: 没有活动选区时粘贴并选中
  (let ((start (point)))  ; 记录粘贴前的位置
    (yank)  ; 执行粘贴
    (set-mark start)  ; 设置标记到粘贴开始位置
    (setq deactivate-mark nil)  ; 防止取消选区
    (setq mark-active t)  ; 激活选区
    ;; (exchange-point-and-mark)  ; 交换点和标记（可选）
    ;; (exchange-point-and-mark)  ; 再次交换回到原位
    (message "已粘贴并选中内容")))
