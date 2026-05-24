;; (require 'meow)
;; ;; 自定义 d 键的行为
;; (defun my/meow-delete ()
;;   "如果有选区，直接删除（不进剪贴板）；否则删除光标后一个字符（不进剪贴板）。"
;;   (interactive)
;;   (if (use-region-p)
;;       ;; 1. 如果有选区：使用 delete-region (纯删除)
;;       (kill-region (region-beginning) (region-end))
;;     ;; 2. 如果无选区：使用 delete-char 1 (纯删除，KILLFLAG 默认为 nil)
;;     (delete-char 1)))

;; (define-key meow-normal-state-keymap (kbd "d") 'my/meow-delete)

;; ;; 绑定 d 键到自定义函数
;; (define-key meow-normal-state-keymap (kbd "d") 'my/meow-delete)

;; (defun my/meow-delete-to-end-of-line-and-insert ()
;;   "删除当前光标到行尾的内容，并进入插入模式。"
;;   (interactive)
;;   (let ((pos (point))) ; 保存当前光标位置
;;     (end-of-line) ; 移动光标到行尾
;;     (kill-region pos (point))) ; 删除从光标到行尾的内容
;;   (meow-insert-mode)) ; 进入插入模式

;; ;; 绑定 C 键到自定义函数
;; (define-key meow-normal-state-keymap (kbd "C") 'my/meow-delete-to-end-of-line-and-insert)


;; ;; 实现插入文本自动选中
;; (defun get-char-under-cursor ()
;;   "获取光标下的字符并显示在 minibuffer 中（交互式调用时）。
;; 返回光标下的字符（作为整数），如果无字符则返回 nil。"
;;   (interactive)
;;   (let ((char (char-after (point))))
;;     (when (called-interactively-p 'interactive)
;;       (if char
;;           (message "字符: %c (Unicode: U+%04X)" char char)
;;         (message "光标处无字符")))
;;     char))  ; 返回字符值
;; ;; (defun my-meow-change ()
;; ;;   "插入原始光标下的字符到缓冲区"
;; ;;   (interactive)
;; ;;   ;; 如果有选中区域，先取消选中
;; ;;   (when (region-active-p)
;; ;;     (deactivate-mark))
;; ;;   (let* ((orig-pos (point))  ; 保存原始位置
;; ;;          (char (save-excursion  ; 在原始位置获取字符
;; ;;                  (goto-char orig-pos)
;; ;;                  (get-char-under-cursor))))
;; ;;     (meow-change)  ; 执行 Meow 的 change 操作
;; ;;     (if char
;; ;;         (insert char)  ; 插入字符
;; ;;       (insert ?\n)     ; 插入换行符
;; ;;       (meow-insert-mode)
;; ;;       ) ; 进入插入模式

;; ;;     (backward-char 1)  ; 向后移动一格
;; ;;     ))

;; ;; (defun my-meow-change ()
;; ;;   "完全兼容版 my-meow-change：
;; ;; 1. 继承 meow-change 退出后选中的特性。
;; ;; 2. 不删除现有文字，支持在最后一个字符后及 EOF 使用。
;; ;; 3. 解决了旧版本中的参数报错问题。"
;; ;;   (interactive)
;; ;;   (if (region-active-p)
;; ;;       ;; 1. 如果已有选区，正常执行原版
;; ;;       (meow-change)
    
;; ;;     ;; 2. 处理无选区情况
;; ;;     (let ((current-prefix-arg 1)) ; 设置临时前缀参数为 1
;; ;;       ;; A. 实现 Append 效果：如果不在行尾，先往后移
;; ;;       (unless (eolp)
;; ;;         (forward-char 1))

;; ;;       ;; B. 插入一个用于被“改变”的空格
;; ;;       (insert " ")
;; ;;       (backward-char 1)

;; ;;       ;; C. 调用选择命令，必须用交互方式以适配 Meow 内部逻辑
;; ;;       ;; 这步会让 Meow 正确选中刚才那个空格
;; ;;       (call-interactively 'meow-right-expand)

;; ;;       ;; D. 此时有了选区，调用 meow-change
;; ;;       ;; 它会删除空格并开始录制输入内容，退出后自动高亮选中
;; ;;       (meow-change))))
;; ;; (defun my-meow-change ()
;; ;;   "完全适配版：
;; ;; 1. 无视现有选区：如果有选区，直接取消（不删除文本）。
;; ;; 2. 在当前光标后追加：实现在光标后插入的效果。
;; ;; 3. 退出后选中：完美继承 meow-change 退出后高亮输入内容的功能。
;; ;; 4. 修复了参数及类型报错。"
;; ;;   (interactive)
;; ;;   ;; 1. 如果有选区，先取消掉，保持原位不动
;; ;;   (when (region-active-p)
;; ;;     (deactivate-mark))

;; ;;   ;; 2. 模拟 Append（在当前字符后插入）
;; ;;   ;; 只有不在行尾时才往后移，如果在 EOF/EOL 则原地不动
;; ;;   (unless (eolp)
;; ;;     (forward-char 1))

;; ;;   ;; 3. 构造“假选区”以触发 meow-change 的记录逻辑
;; ;;   ;; 在光标位置临时插入一个空格，然后通过 Meow 的命令选中这个空格
;; ;;   (let ((current-prefix-arg 1))
;; ;;     (insert " ")
;; ;;     (backward-char 1)
    
;; ;;     ;; 使用交互式调用扩选 1 个字符，确保触发 Meow 内部所有状态机
;; ;;     ;; 这样做是为了绕过之前的 'listp' 和 'argument count' 报错
;; ;;     (call-interactively 'meow-right-expand)

;; ;;     ;; 4. 调用原生 meow-change
;; ;;     ;; 此时 Meow 发现有一个 1 字节的选区（就是刚才那个空格），
;; ;;     ;; 它会删掉空格，进入插入模式，并准备好在退出（ESC）时选中你的输入。
;; ;;     (meow-change)))
;; ;; (defun my-meow-change ()
;; ;;   "直接在你提供的结构上修改：
;; ;; 1. 位置修正为字符前 (i)。
;; ;; 2. 修复撤销 (Undo) 逻辑，一次即可完全还原。
;; ;; 3. 完美继承退出后选中内容功能。"
;; ;;   (interactive)
;; ;;   ;; A. 处理选区：如果有选区则取消，不移动位置
;; ;;   (when (region-active-p)
;; ;;     (deactivate-mark))

;; ;;   ;; 【修正1】删除了之前的 (unless (eolp) (forward-char 1))
;; ;;   ;; 现在它就在当前光标位置操作，即实现 Vim 的 i 风格

;; ;;   ;; B. 构造“假选区”
;; ;;   (let ((current-prefix-arg 1))
;; ;;     ;; 插入一个临时的“牺牲空格”
;; ;;     (insert " ")
;; ;;     (backward-char 1)

;; ;;     ;; 选中这个空格
;; ;;     (call-interactively 'meow-right-expand)

;; ;;     ;; 【修正2】处理撤销：在执行真正插入前，标记接下来的动作可以被合并
;; ;;     ;; 这样随后 meow-change 产生的“删除空格”会和“刚才的插入空格”抵消记录
;; ;;     (when (fboundp 'undo-auto-amalgamate)
;; ;;       (undo-auto-amalgamate))

;; ;;     ;; C. 执行 meow-change
;; ;;     ;; 它会删除空格并开始录制。
;; ;;     ;; 重点：由于它调用的是原版 meow-change，所以退出（ESC）后的高亮功能百分之百有效
;; ;;     (meow-change)))
;; ;; (defun my-meow-change ()
;; ;;   "最终纯净版：实现像 'i' 一样的插入，退出后高亮，且一次 Undo 还原。"
;; ;;   (interactive)
;; ;;   (barf-if-buffer-read-only)
;; ;;   (if (region-active-p)
;; ;;       (meow-change)
;; ;;     (progn
;; ;;       ;; 1. 直接告诉 Meow 状态机：退出插入模式后，从这里（当前点）开始建立选区
;; ;;       (setq-local meow--selection-on-exit (point))
;; ;;       ;; 2. 告诉 Meow 选区类型是字符（必填，否则退出后不会选中）
;; ;;       (setq-local meow--selection-type 'char)
;; ;;       ;; 3. 直接以 Vim 'i' 的方式进入插入模式
;; ;;       ;; 这里的 call-interactively 是为了确保所有 Meow 状态转移逻辑完整执行
;; ;;       (call-interactively 'meow-insert))))
;; (defun my-meow-change ()
;;   "修正所有问题：
;; 1. 实现像 'i' 一样的字符前插入（删除了位移逻辑）。
;; 2. 实现 1 次 meow-undo 彻底还原（通过合并撤销历史）。
;; 3. 使用 meow-change，确保退出选区功能 100% 正常。"
;;   (interactive)
;;   ;; A. 检查只读，并取消选区
;;   (barf-if-buffer-read-only)
;;   (when (region-active-p) (deactivate-mark))

;;   ;; B. 撤销黑魔法：合并撤销步骤
;;   ;; 通过这个内置函数，我们可以让随后的‘插空格’动作和接下来的输入动作被合并成一个。
;;   (undo-auto-amalgamate)

;;   (let ((current-prefix-arg 1))
;;     ;; C. 插入‘牺牲’空格，构造 change 环境 (i 手感)
;;     (insert " ")
;;     (backward-char 1)
    
;;     ;; D. 调用交互式扩选 1 个字符，触发 meow 内部状态
;;     (call-interactively 'meow-right-expand)

;;     ;; E. 调用原汁原味的 meow-change 
;;     ;; 它会删除空格、进入录制状态，退出时通过官方逻辑选中内容。
;;     (meow-change)))

;; ;; 绑定（请务必确认是在 with-eval-after-load meow 之后）
;; (with-eval-after-load 'meow
;;   (meow-normal-define-key
;;    '("i" . my-meow-change)))

;; ;; 绑定键位（例如 c）
;; (defun my-meow-append ()
;;   "插入原始光标下的字符到缓冲区"
;;   (interactive)
;;   ;; 如果有选中区域，先取消选中
;;   (when (region-active-p)
;;     (deactivate-mark))
;;   (meow-append)
;;   (meow-normal-mode)
;;   (my-meow-change)
;;   )
;; (define-key meow-normal-state-keymap (kbd "i") 'my-meow-change)
;; (define-key meow-normal-state-keymap (kbd "a") 'my-meow-append)


;; ;; 自定义 o 键的行为
;; (defun my/insert-line-above ()
;;   "在当前行的上方插入一行，并进入插入模式。"
;;   (interactive)
;;   ;; 如果有选中区域，先取消选中
;;   (when (region-active-p)
;;     (deactivate-mark))

;;   (beginning-of-line)
;;   (newline-and-indent)
;;   (forward-line -1)
;;   (indent-according-to-mode)
;;   (my-meow-change))

;; ;; 自定义 O 键的行为
;; (defun my/insert-line-below ()
;;   "在当前行的下方插入一行，并进入插入模式。"
;;   (interactive)
;;   ;; 如果有选中区域，先取消选中
;;   (when (region-active-p)
;;     (deactivate-mark))

;;   (end-of-line)
;;   (newline-and-indent)
;;   (indent-according-to-mode)
;;   (my-meow-change))

;; ;; 绑定 o 和 O 键
;; (define-key meow-normal-state-keymap (kbd "O") 'my/insert-line-above)
;; (define-key meow-normal-state-keymap (kbd "o") 'my/insert-line-below)

;; ;; 自定义 I 键的行为
;; (defun my/move-to-beginning-and-insert ()
;;   "移动到行首第一个非空白字符后进入 meow 插入模式"
;;   (interactive)
;;   ;; 如果有选中区域，先取消选中
;;   (when (region-active-p)
;;     (deactivate-mark))
;;   (back-to-indentation)    ; 核心：直接使用内置函数跳到缩进位置
;;   ;; (deactivate-mark)        ; 确保取消选区
;;   (my-meow-change))  ; 安全调用 meow 插入模式



;; ;; 自定义 A 键的行为
;; (defun my/move-to-end-and-insert ()
;;   "将光标移动到行尾并进入插入模式，取消选择区域。"
;;   (interactive)
;;   ;; 如果有选中区域，先取消选中
;;   (when (region-active-p)
;;     (deactivate-mark))
;;   (end-of-line) ; 移动到行尾
;;   ;; (deactivate-mark) ; 取消选择区域
;;   (my-meow-change)) ; 进入插入模式

;; ;; 绑定 I 和 A 键
;; (define-key meow-normal-state-keymap (kbd "I") 'my/move-to-beginning-and-insert)
;; (define-key meow-normal-state-keymap (kbd "A") 'my/move-to-end-and-insert)


;; (defun my-yank-and-select ()
;;   "粘贴内容并激活选中区域。如果有活动选区，则替换选区内容。"
;;   (interactive)
;;   (if (use-region-p)  ; 检查是否有活动选区
;;       ;; 情况1: 有活动选区时替换内容
;;       (let ((start (region-beginning))
;;             (end (region-end)))
;;         (delete-region start end)))  ; 删除选区内容
;;   ;; 情况2: 没有活动选区时粘贴并选中
;;   (let ((start (point)))  ; 记录粘贴前的位置
;;     (yank)  ; 执行粘贴
;;     (set-mark start)  ; 设置标记到粘贴开始位置
;;     (setq deactivate-mark nil)  ; 防止取消选区
;;     (setq mark-active t)  ; 激活选区
;;     ;; (exchange-point-and-mark)  ; 交换点和标记（可选）
;;     ;; (exchange-point-and-mark)  ; 再次交换回到原位
;;     (message "已粘贴并选中内容")))
