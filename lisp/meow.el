(use-package surround
  :config)

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("l" . meow-right)
   '("h" . meow-left)
   '("w" . meow-next-word)
   '("e" . meow-mark-word)
   '("b" . meow-back-word)
'("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   ;; '("0" . delete-window)
   ;; '("1" . delete-other-windows)
   ;; '("2" . split-window-below)
   ;; '("3" . split-window-right)
   ;; '("4" . switch-to-buffer-other-frame)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet)
   '("b" . consult-buffer)
   '("s" . avy-goto-char-timer)
   '("
SPC" . (lambda () (interactive) (switch-to-buffer "*scratch*")))
   '("d" . (lambda () (interactive) (switch-to-buffer "*dashboard*")))
   '("e" . (lambda () (interactive) (find-file "~/.emacs.d/lisp/")))
   '("t" . (lambda () (interactive) (find-file "~/todo.org")))
   '("w" . ace-window)
   '("r" . revert-buffer)
   '("S" . surround-insert)
   '("C" . surround-change)
   '("K" . surround-kill)
   '("q" . save-buffers-kill-terminal))
  (meow-normal-define-key
   ;; '("C-f" . scroll-up-command)
   ;; '("C-b" . scroll-down-command)
   '("(" . move-beginning-of-line)
   '(")" . move-end-of-line)
   '("{" . beginning-of-buffer)
   '("}" . end-of-buffer)
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . my-meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   ;; '("s" . meow-delete)
   '("s" . meow-block)
   '("S" . meow-to-block)
   '("w" . meow-next-word)
   '("W" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . my-meow-change)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   ;; '("o" . meow-block)
   ;; '("O" . meow-to-block)
   '("p" . my-yank-and-select)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   ;; '("d" . meow-kill)
   '("D" . meow-kill-whole-line)
   '("T" . meow-swap-grab)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . undo-redo)
   ;; '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("e" . meow-mark-word)
   '("E" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("M-w" . meow-clipboard-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   ;; '("'" . repeat)
   '("'" . kmacro-start-macro-or-insert-counter)
   '("\"" . meow-end-or-call-kmacro)
   '("<escape>" . ignore)
   ;; '("r" . replace-string)
   ;; '("R" . meow-replace)
   ;; '("r" . ((lambda ()
   ;; (interactive)
   ;; (delete-char 1)  ;; 删除当前字符
   ;; (insert (read-char "Replace with: ")) ;; 提示用户输入字符并插入
   ;; )))
   '("/" . isearch-forward)
   '("n" . isearch-repeat-forward)
   '("N" . isearch-repeat-backward)
   '("*" . isearch-forward-symbol-at-point)
   '("=" . indent-region)
   ))

(use-package meow
  :init
  (meow-global-mode 1)
  :config
  (meow-setup)
  (meow-setup-line-number)
  (setq meow-use-cursor-position-hack t
        meow-use-enhanced-selection-effect t)  ;; optional, for visual effect
  (setopt meow-use-clipboard nil
          ;; meow-expand-hint-counts nil
          ))


 


;; 自定义 d 键的行为
(defun my/meow-delete ()
  "如果有选区，删除选区内容；否则删除当前光标下的一个字符。"
  (interactive)
  (if (use-region-p) ; 检查是否有选区
      (meow-kill)    ; 删除选区内容
    (delete-char 1))) ; 仅删除一个字符

;; 绑定 d 键到自定义函数
(define-key meow-normal-state-keymap (kbd "d") 'my/meow-delete)


  (defun my/meow-replace-char-or-region ()
    "替换当前光标下的一个字符或选区内的所有字符。
按下 r 时，光标颜色变为橙色。"
    (interactive)
    ;; 保存当前光标颜色
    (let ((original-cursor-color (face-attribute 'cursor :background)))
      ;; 改变光标颜色为橙色
      (set-face-attribute 'cursor nil :background "orange")
      (if (use-region-p) ; 检查是否有选区
          ;; 如果有选区，替换选区内的所有字符
          (let ((text (read-string "替换为: ")))
            (delete-region (region-beginning) (region-end))
            (insert text))
	;; 如果没有选区，替换当前光标下的一个字符
	(let ((text (read-string "替换为 (按 ESC 取消): ")))
          (unless (string-empty-p text) ; 检查输入是否为空
            (delete-char 1) ; 删除当前字符
            (insert text)))) ; 插入新字符
      ;; 恢复光标颜色
      (set-face-attribute 'cursor nil :background original-cursor-color)))

  ;; 绑定 r 键到自定义函数
  (define-key meow-normal-state-keymap (kbd "r") 'my/meow-replace-char-or-region)

  (defun my/meow-delete-to-end-of-line-and-insert ()
    "删除当前光标到行尾的内容，并进入插入模式。"
    (interactive)
    (let ((pos (point))) ; 保存当前光标位置
      (end-of-line) ; 移动光标到行尾
      (kill-region pos (point))) ; 删除从光标到行尾的内容
    (meow-insert-mode)) ; 进入插入模式

  ;; 绑定 C 键到自定义函数
  (define-key meow-normal-state-keymap (kbd "C") 'my/meow-delete-to-end-of-line-and-insert)


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
  (deactivate-mark)        ; 确保取消选区
  (my-meow-change))  ; 安全调用 meow 插入模式


  
;; 自定义 A 键的行为
(defun my/move-to-end-and-insert ()
    "将光标移动到行尾并进入插入模式，取消选择区域。"
    (interactive)
    ;; 如果有选中区域，先取消选中
    (when (region-active-p)
      (deactivate-mark))
    (end-of-line) ; 移动到行尾
    (deactivate-mark) ; 取消选择区域
    (my-meow-change)) ; 进入插入模式

  ;; 绑定 I 和 A 键
  (define-key meow-normal-state-keymap (kbd "I") 'my/move-to-beginning-and-insert)
  (define-key meow-normal-state-keymap (kbd "A") 'my/move-to-end-and-insert)


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

;; (defun my-meow-change ()
;;   "插入当前光标下的字符到缓冲区"
;;   (interactive)
;;   (let ((char (get-char-under-cursor)))
;;   (meow-change)
;;     (if char
;;         (insert char)
;;       (backward-char 1)  ; 向前移动一格
;;       (message "光标处无字符，无法插入")))
;;   )

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
      (meow-insert-mode)) ; 进入插入模式

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

(defun my-yank-and-select ()
  "粘贴内容并激活选中区域"
  (interactive)
  (let ((start (point)))  ; 记录粘贴前的位置
    (yank)  ; 执行粘贴
    (let ((end (point)))  ; 记录粘贴后的位置
    
    ;; 详细调试信息
    (message "粘贴前位置: %d" start)
    (message "粘贴后位置: %d" (point))
    (message "原始标记位置: %s" (mark t))
    (message "原始标记激活状态: %s" mark-active)
    
    ;; 直接操作标记系统
    (setq deactivate-mark nil)  ; 防止标记被取消
    (set-mark start)  ; 设置标记位置
    (setq mark-active t)  ; 强制激活标记
    
    ;; 交换点和标记
    (exchange-point-and-mark)
    (exchange-point-and-mark)
    
    ;; 强制重绘显示
    (redisplay)
    (message "已粘贴并选中内容"))))
