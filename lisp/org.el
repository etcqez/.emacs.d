;; (use-package org
;;   :ensure nil
;;   :custom-face
;;   ;; 设置org mode标题以及美级标题行的大小
;;   (org-document-title ((t (:height 1.75 :weight bold))))
;;   (org-level-1 ((t (:height 1.4 :weight bold))))
;;   (org-level-2 ((t (:height 1.35 :weight bold))))
;;   (org-level-3 ((t (:height 1.3 :weight bold))))
;;   (org-level-4 ((t (:height 1.25 :weight bold))))
;;   (org-level-5 ((t (:height 1.2 :weight bold))))
;;   (org-level-6 ((t (:height 1.15 :weight bold))))
;;   (org-level-7 ((t (:height 1.1 :weight bold))))
;;   (org-level-8 ((t (:height 1.05 :weight bold))))
;;   (org-level-9 ((t (:height 1.0 :weight bold))))

;;   ;; 设置代码块用上下边线包裹
;;   (org-block-begin-line ((t (:underline t :background unspecified))))
;;   (org-block-end-line ((t (:overline t :underline nil :background unspecified))))
;;   :config
;;   ;; 设置org mode中某些标签的显示字符
;;   (prettify-symbols-mode 1)
;;   ;; 设置折叠符号
;;   :custom
;;   (setq org-return-follows-link nil)
;;   (setq org-cycle-emulate-tab nil)
;;   (setq org-hide-leading-stars t)
;;   (custom-set-variables
;;    '(org-hide-leading-stars t)
;;    '(org-odd-levels-only t))  ; 只使用奇数级别，配合隐藏星号效果更好
;;   )

(use-package org
  :ensure nil
  :custom-face
  ;; 设置org mode标题以及各级标题行的大小
  (org-document-title ((t (:height 1.75 :weight bold))))
  (org-level-1 ((t (:height 1.4 :weight bold))))
  (org-level-2 ((t (:height 1.35 :weight bold))))
  (org-level-3 ((t (:height 1.3 :weight bold))))
  (org-level-4 ((t (:height 1.25 :weight bold))))
  (org-level-5 ((t (:height 1.2 :weight bold))))
  (org-level-6 ((t (:height 1.15 :weight bold))))
  (org-level-7 ((t (:height 1.1 :weight bold))))
  (org-level-8 ((t (:height 1.05 :weight bold))))
  (org-level-9 ((t (:height 1.0 :weight bold))))

  ;; 设置代码块用上下边线包裹
  (org-block-begin-line ((t (:underline t :background unspecified))))
  (org-block-end-line ((t (:overline t :underline nil :background unspecified))))
  
  :custom
  ;; 使用 :custom 来设置变量
  (org-return-follows-link nil)
  ;; (org-cycle-emulate-tab nil)
  (org-hide-leading-stars t)
  ;; (org-odd-levels-only t)  ; 只使用奇数级别，配合隐藏星号效果更好
  
  :config
  ;; 设置org mode中某些标签的显示字符
  (prettify-symbols-mode 1)
  )

;; (use-package org-modern
;;   :ensure t
;;   :hook (after-init . (lambda ()
;; 			(setq org-modern-hide-stars 'leading)
;; 			(global-org-modern-mode t)
;; 			))
  
;;   :config
;;   ;; 定义各级标题行字符
;;   (setq org-modern-star ["◉" "○" "✸" "✳" "◈" "◇" "✿" "❀" "✜"])
;;   ;; (setq org-modern-label-border 1)
;;   ;; (setq org-modern-table-vectical 2)
;;   ;; (setq org-modern-table-horizontal 0)

;;   ;; ;; 代码块左边加上一条竖边线
;;   ;; (setq org-modern-block-fringe t)
;; )

(use-package valign
  :ensure t
  :config
  (add-hook 'org-mode-hook #'valign-mode))
