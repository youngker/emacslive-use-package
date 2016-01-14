(use-package ido
  :defer t
  :bind (("C-x C-f" . ido-find-file)
         ("C-x b"   . ido-switch-buffer)
         ("C-x B"   . ido-switch-buffer-other-window)
         ("C-x f"   . live-recentf-ido-find-file))
  :config
  (use-package flx-ido
    :config
    (flx-ido-mode t)
    (setq ido-use-face nil))

  (use-package ido-vertical-mode
    :config
    (ido-vertical-mode)
    (setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right))

  (ido-mode t)
  (icomplete-mode 1)
  (setq ido-enable-prefix nil
        ido-create-new-buffer 'always
        ido-max-prospects 10
        ido-default-file-method 'selected-window
        ido-everywhere 1)
  (defvar live-symbol-names)
  (defvar live-name-and-pos)
  (define-key ido-file-completion-map (kbd "C-\\") 'backward-kill-word)
  (defun live-recentf-ido-find-file ()
    "Find a recent file using ido."
    (interactive)
    (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
      (when file
        (find-file file))))

  (defun live-ido-goto-symbol (&optional symbol-list)
    "Refresh imenu and jump to a place in the buffer using Ido."
    (interactive)
    (unless (featurep 'imenu)
      (require 'imenu nil t))
    (cond
     ((not symbol-list)
      (let ((ido-mode ido-mode)
            (ido-enable-flex-matching
             (if (boundp 'ido-enable-flex-matching)
                 ido-enable-flex-matching t))
            live-name-and-pos live-symbol-names position selected-symbol)
        (unless ido-mode
          (ido-mode 1)
          (setq ido-enable-flex-matching t))
        (while (progn
                 (imenu--cleanup)
                 (setq imenu--index-alist nil)
                 (live-ido-goto-symbol (imenu--make-index-alist))
                 (setq selected-symbol
                       (ido-completing-read "Symbol? " live-symbol-names))
                 (string= (car imenu--rescan-item) selected-symbol)))
        (unless (and (boundp 'mark-active) mark-active)
          (push-mark nil t nil))
        (setq position (cdr (assoc selected-symbol live-name-and-pos)))
        (cond
         ((overlayp position)
          (goto-char (overlay-start position)))
         (t
          (goto-char position)))))
     ((listp symbol-list)
      (dolist (symbol symbol-list)
        (let (name position)
          (cond
           ((and (listp symbol) (imenu--subalist-p symbol))
            (live-ido-goto-symbol symbol))
           ((listp symbol)
            (setq name (car symbol))
            (setq position (cdr symbol)))
           ((stringp symbol)
            (setq name symbol)
            (setq position
                  (get-text-property 1 'org-imenu-marker symbol))))
          (unless (or (null position) (null name)
                      (string= (car imenu--rescan-item) name))
            (add-to-list 'live-symbol-names name)
            (add-to-list 'live-name-and-pos (cons name position)))))))))

(use-package idomenu
  :defer t
  :commands (idomenu))
