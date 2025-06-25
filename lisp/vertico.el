(defvar my-toggle-map (make-keymap))
(defvar my-quit-map (make-keymap))
(defvar my-error-map (make-keymap))

;; ;; The `vertico' package applies a vertical layout to the minibuffer.
;; ;; It also pops up the minibuffer eagerly so we can see the available
;; ;; options without further interactions.  This package is very fast
;; ;; and "just works", though it also is highly customisable in case we
;; ;; need to modify its behaviour.
;; ;;
;; ;; Further reading: https://protesilaos.com/emacs/dotemacs#h:cff33514-d3ac-4c16-a889-ea39d7346dc5
;; (use-package vertico
;;   :ensure t
;;   :config
;;   (setq vertico-cycle t)
;;   (setq vertico-resize nil)
;;   (vertico-mode 1))

;; ;; The `marginalia' package provides helpful annotations next to
;; ;; completion candidates in the minibuffer.  The information on
;; ;; display depends on the type of content.  If it is about files, it
;; ;; shows file permissions and the last modified date.  If it is a
;; ;; buffer, it shows the buffer's size, major mode, and the like.
;; ;;
;; ;; Further reading: https://protesilaos.com/emacs/dotemacs#h:bd3f7a1d-a53d-4d3e-860e-25c5b35d8e7e
;; (use-package marginalia
;;   :ensure t
;;   :config
;;   (marginalia-mode 1))

;; The `orderless' package lets the minibuffer use an out-of-order
;; pattern matching algorithm.  It matches space-separated words or
;; regular expressions in any order.  In its simplest form, something
;; like "ins pac" matches `package-menu-mark-install' as well as
;; `package-install'.  This is a powerful tool because we no longer
;; need to remember exactly how something is named.
;;
;; Note that Emacs has lots of "completion styles" (pattern matching
;; algorithms), but let us keep things simple.
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:7cc77fd0-8f98-4fc0-80be-48a758fcb6e2
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))

;; The `consult' package provides lots of commands that are enhanced
;; variants of basic, built-in functionality.  One of the headline
;; features of `consult' is its preview facility, where it shows in
;; another Emacs window the context of what is currently matched in
;; the minibuffer.  Here I define key bindings for some commands you
;; may find useful.  The mnemonic for their prefix is "alternative
;; search" (as opposed to the basic C-s or C-r keys).
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:22e97b4c-d88d-4deb-9ab3-f80631f9ff1d




(use-package vertico
  :init
  (setq vertico-cycle t)
  (vertico-mode +1))
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
        completion-category-overrides nil)

  (with-eval-after-load 'migemo
    ;; orderlessをmigemo対応
    (defun orderless-migemo (component)
      (let ((pattern (downcase (migemo-get-pattern component))))
        (condition-case nil
            (progn (string-match-p pattern "") pattern)
          (invalid-regexp nil))))
    (add-to-list 'orderless-matching-styles 'orderless-migemo))

  (with-eval-after-load 'corfu
    (defun orderless-fast-dispatch (word index total)
      (and (= index 0) (= total 1) (length< word 4)
           'orderless-literal-prefix))

    (orderless-define-completion-style orderless-fast
      (orderless-style-dispatchers '(orderless-fast-dispatch))
      (orderless-matching-styles '(orderless-flex)))

    (defun my/setup-corfu-for-orderless ()
      (setq-local corfu-auto-delay 0
                  corfu-auto-prefix 1
                  completion-styles '(orderless-fast)))

    (add-hook 'corfu-mode-hook #'my/setup-corfu-for-orderless)))



