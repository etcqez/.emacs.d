;; (use-package consult
;;   :ensure t
;;   :bind (;; A recursive grep
;;          ("M-s M-g" . consult-grep)
;;          ;; Search for files names recursively
;;          ("M-s M-f" . consult-find)
;;          ("M-s M-f" . consult-find)
;;          ;; Search through the outline (headings) of the file
;;          ("M-s M-o" . consult-outline)
;;          ;; Search the current buffer
;;          ("M-s M-s" . consult-line)
;;          ;; Switch to another buffer, or bookmarked file, or recently
;;          ;; opened file.
;;          ("M-s M-b" . consult-buffer)))

;; ;; The `embark' package lets you target the thing or context at point
;; ;; and select an action to perform on it.  Use the `embark-act'
;; ;; command while over something to find relevant commands.
;; ;;
;; ;; When inside the minibuffer, `embark' can collect/export the
;; ;; contents to a fully fledged Emacs buffer.  The `embark-collect'
;; ;; command retains the original behaviour of the minibuffer, meaning
;; ;; that if you navigate over the candidate at hit RET, it will do what
;; ;; the minibuffer would have done.  In contrast, the `embark-export'
;; ;; command reads the metadata to figure out what category this is and
;; ;; places them in a buffer whose major mode is specialised for that
;; ;; type of content.  For example, when we are completing against
;; ;; files, the export will take us to a `dired-mode' buffer; when we
;; ;; preview the results of a grep, the export will put us in a
;; ;; `grep-mode' buffer.
;; ;;
;; ;; Further reading: https://protesilaos.com/emacs/dotemacs#h:61863da4-8739-42ae-a30f-6e9d686e1995
;; (use-package embark
;;   :ensure t
;;   :bind (("C-." . embark-act)
;;          :map minibuffer-local-map
;;          ("C-c C-c" . embark-collect)
;;          ("C-c C-e" . embark-export)))

;; ;; The `embark-consult' package is glue code to tie together `embark'
;; ;; and `consult'.
;; (use-package embark-consult
;;   :ensure t)

;; ;; The `wgrep' packages lets us edit the results of a grep search
;; ;; while inside a `grep-mode' buffer.  All we need is to toggle the
;; ;; editable mode, make the changes, and then type C-c C-c to confirm
;; ;; or C-c C-k to abort.
;; ;;
;; ;; Further reading: https://protesilaos.com/emacs/dotemacs#h:9a3581df-ab18-4266-815e-2edd7f7e4852
;; (use-package wgrep
;;   :ensure t
;;   :bind ( :map grep-mode-map
;;           ("e" . wgrep-change-to-wgrep-mode)
;;           ("C-x C-q" . wgrep-change-to-wgrep-mode)
;;           ("C-c C-c" . wgrep-finish-edit)))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ([remap switch-to-buffer] . consult-buffer)                ;; orig. switch-to-buffer
         ([remap switch-to-buffer-other-window] . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ([remap switch-to-buffer-other-frame] . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ([remap bookmark-jump] . consult-bookmark)            ;; orig. bookmark-jump
         ([remap project-switch-to-buffer] . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         :map goto-map
         ("e" . consult-compile-error)
         ("f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("g" . consult-goto-line)             ;; orig. goto-line
         ("M-g" . consult-goto-line)           ;; orig. goto-line
         ("o" . consult-outline)               ;; Alternative: consult-org-heading
         ("m" . consult-mark)
         ("k" . consult-global-mark)
         ("i" . consult-imenu)
         ("I" . consult-imenu-multi)
         :map search-map
         ("d" . consult-fd)
         ("D" . consult-locate)
         ("g" . consult-grep)
         ("G" . consult-git-grep)
         ("r" . consult-ripgrep)
         ("l" . consult-line)
         ("L" . consult-line-multi)
         ("m" . consult-multi-occsur)
         ("k" . consult-keep-lines)
         ("u" . consult-focus-lines)
         ("e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-hisstory)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history)
         :map my-error-map
         ("e" . consult-flymake))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  (with-eval-after-load 'meow
    (meow-leader-define-key
     '("b" . consult-buffer)))

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 1.0 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;; There are multiple reasonable alternatives to chose from.
    ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
    ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
    ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
    ;;;; 4. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
  )

(use-package marginalia
  :init
  (marginalia-mode +1))
(use-package embark
  :bind (("C-." . embark-act)         ;; pick some comfortable binding
         ("C-;" . embark-dwim)        ;; good alternative: M-.
         ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))
(use-package embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))


;; 删除路径
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
