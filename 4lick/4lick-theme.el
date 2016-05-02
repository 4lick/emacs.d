;; Themes
(add-to-list 'custom-theme-load-path (concat dotfiles-dir "themes"))
(add-to-list 'load-path (concat dotfiles-dir "themes"))

(set-face-attribute 'default nil :height 140)
(load-theme 'default-black t)
;;(load-theme 'prez t)

(provide '4lick-theme)
