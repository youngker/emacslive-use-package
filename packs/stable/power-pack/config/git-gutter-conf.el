(use-package git-gutter
  :defer t
  :init
  (progn
    (setq git-gutter:window-width 2)
    (setq git-gutter:lighter " G-+")
    (setq git-gutter:modified-sign "~ ")
    (setq git-gutter:added-sign "+ ")
    (setq git-gutter:deleted-sign "- ")
    (setq git-gutter:unchanged-sign "  "))
  :config
  (global-git-gutter-mode t))
