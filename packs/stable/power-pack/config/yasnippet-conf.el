(require 'yasnippet)
(setq live-yasnippet-dir (concat live-etc-dir "snippets"))
(setq yas-snippet-dirs `(,live-yasnippet-dir))
(yas-global-mode 1)
