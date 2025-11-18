(use-package company
  :demand t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-dabbrev-ignore-case nil)  ; 禁用忽略大小写
  (setq company-dabbrev-downcase nil)     ; 禁用自动转小写
  (setq company-minimum-prefix-length 1)  ; 输入 1 个字符即触发补全
  (setq company-idle-delay 0)  ; 输入后立即触发，无延迟
  (setq company-frontends '(company-pseudo-tooltip-frontend))  ; 仅保留工具提示
  (setq company-allow-wrap t)  ; 允许候选菜单循环选择
  (setq vertico-cycle t)  ; vertico 的循环选择
  )
