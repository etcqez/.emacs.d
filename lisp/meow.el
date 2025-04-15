(use-package surround
  :config)

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
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
   '("a" . meow-append)
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
   '("i" . meow-insert)
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
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   ;; '("d" . meow-kill)
   '("D" . meow-kill-whole-line)
   '("T" . meow-swap-grab)
   '("t" . meow-till)
   '("u" . undo)
   '("U" . undo-redo)
   ;; '("U" . meow-undo-in-selection)
   '("v" . set-mark-command)
   '("e" . meow-mark-word)
   '("E" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
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
  (setopt meow-use-clipboard t
          ;; meow-expand-hint-counts nil
          )


  ;; ;; 定义变量来记录插入模式的起始位置
  ;; (defvar my/meow-insert-start nil
  ;;   "记录进入插入模式时的光标位置。")

  ;; ;; 进入插入模式时记录起始位置
  ;; (defun my/meow-record-insert-start ()
  ;;   (setq my/meow-insert-start (point)))

  ;; ;; 退出插入模式时选中插入的内容
  ;; (defun my/meow-select-inserted-text ()
  ;;   (when my/meow-insert-start
  ;;     (let ((end (point)))
  ;;       (set-mark my/meow-insert-start)
  ;;       (goto-char end)
  ;;       (setq my/meow-insert-start nil))))

  ;; ;; 绑定到插入模式的钩子
  ;; (add-hook 'meow-insert-enter-hook 'my/meow-record-insert-start)
  ;; (add-hook 'meow-insert-exit-hook 'my/meow-select-inserted-text)


  ;;  ;; 定义变量来存储插入的文本范围
  ;; (defvar my/meow-insert-start nil
  ;;   "Store the start position of inserted text.")
  ;; (defvar my/meow-insert-end nil
  ;;   "Store the end position of inserted text.")

  ;; ;; 在文本插入时更新范围
  ;; (defun my/meow-track-inserted-text (start end length)
  ;;   (when (and (null my/meow-insert-start) ; 如果尚未记录起始位置
  ;;              (> end start))               ; 如果有文本插入
  ;;     (setq my/meow-insert-start start
  ;;           my/meow-insert-end end))
  ;;   (when (and my/meow-insert-start
  ;;              (> end start))               ; 忽略删除操作
  ;;     (setq my/meow-insert-end end)))

  ;; ;; 进入插入模式时初始化
  ;; (defun my/meow-record-insert-start ()
  ;;   (setq my/meow-insert-start nil
  ;;         my/meow-insert-end nil)
  ;;   (add-hook 'after-change-functions 'my/meow-track-inserted-text nil t))

  ;; ;; 退出插入模式时选中插入的文本
  ;; (defun my/meow-select-inserted-text ()
  ;;   (remove-hook 'after-change-functions 'my/meow-track-inserted-text t)
  ;;   (when (and my/meow-insert-start my/meow-insert-end)
  ;;     (set-mark my/meow-insert-start)
  ;;     (goto-char my/meow-insert-end)
  ;;     (activate-mark)))
  
  ;; ;; 绑定到插入模式的进入和退出钩子
  ;; (add-hook 'meow-insert-enter-hook 'my/meow-record-insert-start)
  ;; (add-hook 'meow-insert-exit-hook 'my/meow-select-inserted-text)
  

  ;; 定义变量来存储插入的文本范围
  (defvar my/meow-insert-start nil
    "Store the start position of inserted text.")
  (defvar my/meow-insert-end nil
    "Store the end position of inserted text.")

  ;; 在文本插入时更新范围
  (defun my/meow-track-inserted-text (start end length)
    "Track the range of inserted text."
    (when (and (null my/meow-insert-start) ; 如果尚未记录起始位置
               (> end start))               ; 如果有文本插入
      (setq my/meow-insert-start start))
    (when (and my/meow-insert-start
               (> end start))               ; 忽略删除操作
      (setq my/meow-insert-end end)))

  ;; 进入插入模式时初始化
  (defun my/meow-record-insert-start ()
    "Initialize tracking when entering insert mode."
    (setq my/meow-insert-start (point) ; 记录插入模式的起始位置
          my/meow-insert-end nil)
    (add-hook 'after-change-functions 'my/meow-track-inserted-text nil t))

  ;; 退出插入模式时选中插入的文本
  (defun my/meow-select-inserted-text ()
    "Select the inserted text when exiting insert mode."
    (remove-hook 'after-change-functions 'my/meow-track-inserted-text t)
    (when (and my/meow-insert-start my/meow-insert-end)
      ;; 确保选中范围包括所有插入的文本
      (set-mark my/meow-insert-start)
      (goto-char my/meow-insert-end)
      (activate-mark)))

  ;; 绑定到插入模式的进入和退出钩子
  (add-hook 'meow-insert-enter-hook 'my/meow-record-insert-start)
  (add-hook 'meow-insert-exit-hook 'my/meow-select-inserted-text)

  (let ((bounds (bounds-of-thing-at-point 'sexp)))
    (when bounds
      (set-mark (car bounds))
      (goto-char (cdr bounds))
      (activate-mark)))

  ;; 自定义 d 键的行为
  (defun my/meow-delete ()
    "如果有选区，删除选区内容；否则删除当前光标下的一个字符。"
    (interactive)
    (if (use-region-p) ; 检查是否有选区
        ;; (delete-region (region-beginning) (region-end)) ; 删除选区内容
        (meow-kill)
      (meow-delete))) ; 删除当前光标下的一个字符

  ;; 绑定 d 键到自定义函数
  (define-key meow-normal-state-keymap (kbd "d") 'my/meow-delete)


  ;;   (defun my/meow-replace-char-or-region ()
  ;;     "替换当前光标下的一个字符或选区内的所有字符。
  ;; 按下 r 时，光标颜色变为橙色。"
  ;;     (interactive)
  ;;     ;; 保存当前光标颜色
  ;;     (let ((original-cursor-color (face-attribute 'cursor :background)))
  ;;       ;; 改变光标颜色为橙色
  ;;       (set-face-attribute 'cursor nil :background "orange")
  ;;       (if (use-region-p) ; 检查是否有选区
  ;;           ;; 如果有选区，替换选区内的所有字符
  ;;           (let ((text (read-string "替换为: ")))
  ;;             (delete-region (region-beginning) (region-end))
  ;;             (insert text))
  ;;         ;; 如果没有选区，替换当前光标下的一个字符
  ;;         (let ((char (read-char "替换为 (按 ESC 取消): ")))
  ;;           (unless (eq char 27) ; 27 是 ESC 的 ASCII 码
  ;;             (delete-char 1)
  ;;             (insert char))))
  ;;       ;; 恢复光标颜色
  ;;       (set-face-attribute 'cursor nil :background original-cursor-color)))

  ;;   ;; 绑定 r 键到自定义函数
  ;;   (define-key meow-normal-state-keymap (kbd "r") 'my/meow-replace-char-or-region)
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
    (beginning-of-line)
    (newline-and-indent)
    (forward-line -1)
    (indent-according-to-mode)
    (meow-insert-mode))

  ;; 自定义 O 键的行为
  (defun my/insert-line-below ()
    "在当前行的下方插入一行，并进入插入模式。"
    (interactive)
    (end-of-line)
    (newline-and-indent)
    (indent-according-to-mode)
    (meow-insert-mode))

  ;; 绑定 o 和 O 键
  (define-key meow-normal-state-keymap (kbd "O") 'my/insert-line-above)
  (define-key meow-normal-state-keymap (kbd "o") 'my/insert-line-below)

  ;; 自定义 I 键的行为
  ;; (defun my/move-to-beginning-and-insert ()
  ;;   "将光标移动到行首并进入插入模式，取消选择区域。"
  ;;   (interactive)
  ;;   (beginning-of-line) ; 移动到行首
  ;;   (deactivate-mark) ; 取消选择区域
  ;;   (meow-insert-mode)) ; 进入插入模式

(defun my/move-to-beginning-and-insert ()
  "移动到行首第一个非空白字符后进入 meow 插入模式"
  (interactive)
  (back-to-indentation)    ; 核心：直接使用内置函数跳到缩进位置
  (deactivate-mark)        ; 确保取消选区
  (meow-insert))  ; 安全调用 meow 插入模式


  
  ;; 自定义 A 键的行为
  (defun my/move-to-end-and-insert ()
    "将光标移动到行尾并进入插入模式，取消选择区域。"
    (interactive)
    (end-of-line) ; 移动到行尾
    (deactivate-mark) ; 取消选择区域
    (meow-insert-mode)) ; 进入插入模式

  ;; 绑定 I 和 A 键
  (define-key meow-normal-state-keymap (kbd "I") 'my/move-to-beginning-and-insert)
  (define-key meow-normal-state-keymap (kbd "A") 'my/move-to-end-and-insert)


  ;;   ;; 自定义 h 和 l 的行为
  ;; (defun my/meow-left ()
  ;;   "向左移动光标。"
  ;;   (interactive)
  ;;   (backward-char 1))

  ;; (defun my/meow-right ()
  ;;   "向右移动光标。"
  ;;   (interactive)
  ;;   (forward-char 1))

  ;; ;; 绑定 h 和 l 到自定义函数
  ;; (define-key meow-normal-state-keymap (kbd "h") 'my/meow-left)
  ;; (define-key meow-normal-state-keymap (kbd "l") 'my/meow-right)

  ;; ;; 绑定 C-f 和 C-b 到翻页
  ;; (define-key meow-normal-state-keymap (kbd "C-f") 'scroll-up-command)
  ;; (define-key meow-normal-state-keymap (kbd "C-b") 'scroll-down-command)

  ;;   ;; 恢复 H 和 L 的默认行为
  ;; (define-key meow-normal-state-keymap (kbd "H") 'meow-expand-0) ; 向左选择
  ;; (define-key meow-normal-state-keymap (kbd "L") 'meow-expand-1) ; 向右选择

  )
