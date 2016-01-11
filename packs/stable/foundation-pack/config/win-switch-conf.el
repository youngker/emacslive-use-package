(use-package win-switch
  :defer t
  :init
  (progn
    (setq win-switch-feedback-background-color "DeepPink3")
    (setq win-switch-feedback-foreground-color "black")
    (setq win-switch-window-threshold 1)
    (setq win-switch-idle-time 0.7))
  :config
  (progn
    (win-switch-set-keys '() 'up)
    (win-switch-set-keys '() 'down)
    (win-switch-set-keys '() 'left)
    (win-switch-set-keys '() 'right)
    (win-switch-set-keys '("o") 'next-window)
    (win-switch-set-keys '("p") 'previous-window)
    (win-switch-set-keys '() 'enlarge-vertically)
    (win-switch-set-keys '() 'shrink-vertically)
    (win-switch-set-keys '() 'shrink-horizontally)
    (win-switch-set-keys '() 'enlarge-horizontally)
    (win-switch-set-keys '() 'other-frame)
    (win-switch-set-keys '("C-g") 'exit)
    (win-switch-set-keys '() 'split-horizontally)
    (win-switch-set-keys '() 'split-vertically)
    (win-switch-set-keys '() 'delete-window)
    (win-switch-set-keys '("\M-\C-g") 'emergency-exit)))
