;; Install json-mode and make its reformat keybinding match the global default.
(use-package json-mode
  :commands json-mode
  :config
  (bind-keys :map json-mode-map
             ("C-c <tab>" . json-mode-beautify)))

;; Install yaml-mode
(use-package yaml-mode
    :mode ("\\.yml\\'" . yaml-mode))

(provide '4lick-format)
