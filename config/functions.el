;; 启用 savehist 模式
(savehist-mode 1)
(setq savehist-file "~/.emacs.d/.histort/savehist") ; 保存历史记录的路径

;; 启用 recentf 模式
(recentf-mode 1)
(setq recentf-save-file "~/.emacs.d/.histort/recentf") ; 保存最近文件的路径
(setq recentf-max-saved-items 100) ; 设置最大保存文件数量

;; 设置 minibuffer 输入历史
(setq history-length 1000) ; 设置历史记录的长度
(setq savehist-file "~/.emacs.d/.histort/minibuffer-history") ; 保存 minibuffer 历史的路径

;; 启用 save-place 模式，设置位置文件
(save-place-mode 1)

;; (global-display-line-numbers-mode 1)
(setq auto-save-default nil)

;; 终端复制
(use-package xclip
  :ensure t
  :config
  (xclip-mode 1)
  )

