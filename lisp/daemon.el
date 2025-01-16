(add-hook 'server-after-make-frame-hook
          (lambda ()
            (dashboard-refresh-buffer)
            ))
