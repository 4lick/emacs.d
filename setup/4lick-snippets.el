;;; Snippet:

(require '4lick-package)

;; The s.el package contains a lot of functions useful in snippets.
(use-package s)

;; Read about it here: http://capitaomorte.github.io/yasnippet/
(use-package yasnippet
  ;;:commands yas-global-mode
  :config
  (yas-global-mode 1)
  :diminish yas-minor-mode)

(provide '4lick-snippets)
;;; 4lick-snippets.el ends here
