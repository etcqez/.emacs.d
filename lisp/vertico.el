(use-package vertico
  :init
  (setq vertico-cycle t)
  (vertico-mode +1)
  (vertico-mouse-mode))
(use-package vertico-repeat
  :ensure nil
  :after vertico
  :hook (minibuffer-setup . vertico-repeat-save)
  :init
  (with-eval-after-load 'meow
    (meow-leader-define-key
     '("z" . vertico-repeat))))

(use-package vertico-directory
  :ensure nil
  :after vertico
  :bind ( :map vertico-map
          ("<backspace>" . vertico-directory-delete-char)))

(use-package vertico-buffer
  :ensure nil
  :config
  (setq vertico-buffer-display-action '(display-buffer-at-bottom))
  (vertico-buffer-mode +1))
(defvar +vertico-current-arrow t)

(cl-defmethod vertico--format-candidate :around
  (cand prefix suffix index start &context ((and +vertico-current-arrow
                                                 (not (bound-and-true-p vertico-flat-mode)))
                                            (eql t)))
  (setq cand (cl-call-next-method cand prefix suffix index start))
  (let ((arrow (nerd-icons-faicon "nf-fa-hand_o_right")))
    (if (bound-and-true-p vertico-grid-mode)
        (if (= vertico--index index)
            (concat arrow " " cand)
          (concat #("_" 0 1 (display " ")) cand))
      (if (= vertico--index index)
          (concat " " arrow " " cand)
        (concat "    " cand)))))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides nil))

;; 完整的 consult 配置
(use-package consult
  :ensure t
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  ;; 用 consult 替换标准绑定
  (global-set-key [remap switch-to-buffer] #'consult-buffer)
  (global-set-key [remap switch-to-buffer-other-window] #'consult-buffer-other-window)
  (global-set-key [remap switch-to-buffer-other-frame] #'consult-buffer-other-frame)
  (global-set-key [remap goto-line] #'consult-goto-line)
  (global-set-key [remap imenu] #'consult-imenu)
  (global-set-key [remap yank-pop] #'consult-yank-pop)
  (global-set-key [remap bookmark-jump] #'consult-bookmark)
  (global-set-key [remap recentf-open] #'consult-recent-file)
  
  :config
  ;; 项目根目录检测
  (setq consult-project-root-function
        (lambda ()
          (when-let (project (project-current))
            (project-root project))))
  
  ;; ;; 自定义缓冲区源顺序
  ;; (consult-customize consult--source-buffer :hidden t :default nil)
  ;; (consult-customize consult--source-project-buffer :hidden t :default nil)
  
  ;; 自定义预览行为
  (setq consult-preview-excluded-files
        (regexp-opt '(".git/" ".hg/" ".svn/" "build/" "target/" "node_modules/"))))
