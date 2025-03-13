;; ;; 启用 subword-mode，增强单词边界识别
;; (global-subword-mode 1)

;; ;; 设置 CJK 字符按单词删除
;; (setq-default word-wrap-by-category t)

;; ;; 自定义删除单词函数
;; (defun my/backward-kill-word ()
;;   "删除光标前的一个单词（支持中文）。"
;;   (interactive)
;;   (let ((pos (point)))
;;     (backward-word 1) ; 向后移动一个单词
;;     (kill-region pos (point)))) ; 删除从光标到移动后位置的文本

;; ;; 绑定到 Alt-Backspace
;; (global-set-key (kbd "M-<backspace>") 'my/backward-kill-word)

(add-to-list 'load-path "~/emacs-chinese-word-segmentation/")
(setq cns-prog "~/emacs-chinese-word-segmentation/cnws")
(setq cns-dict-directory "~/emacs-chinese-word-segmentation/cppjieba/dict")

;; 若使用其它中文分词软件, 需要设置 cns-process-shell-command:
;; (setq cns-process-shell-command "word_segmentation_program arg1 arg2...")

;; Windows 平台（指官方 windows 版 Emacs）请先检查或设置
;; cns-cmdproxy-shell-path，默认优先选择 WSL 环境，因为编译后分词软件
;; 的运行速度在 WSL 中比 Cygwin 速度快，若选择使用 Cygwin 平台作为编译
;; 环境，需要手工设置好 cns-cmdproxy-shell-path。
;;
;; (setq cns-cmdproxy-shell-path "wsl.exe bash")
;; 或
;; (setq cns-cmdproxy-shell-path "C:/cygwin64/bin/bash.exe")

(setq cns-recent-segmentation-limit 20) ; default is 10
(setq cns-debug nil) ; disable debug output, default is t
(require 'cns nil t)
(when (featurep 'cns)
  (add-hook 'find-file-hook 'cns-auto-enable))
