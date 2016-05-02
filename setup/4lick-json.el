;; Install json-mode and make its reformat keybinding match the global default.
(use-package json-mode
  :commands json-mode
  :config
  (bind-keys :map json-mode-map
             ("C-c <tab>" . json-mode-beautify)))

(provide '4lick-json)
