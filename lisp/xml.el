;; associate xml, xsd, etc with nxml-mode
(add-to-list 'auto-mode-alist (cons (concat "\\." (regexp-opt '("xml" "xsd" "rng" "xslt" "xsl") t) "\\'") 'nxml-mode))
(setq nxml-slash-auto-complete-flag t)

