(require '4lick-package)

;; Haskell
(use-package intero
   :mode ("\\.hs\\'" . intero-mode)
  :init
  (add-hook 'haskell-mode-hook 'intero-mode))

(provide '4lick-haskell)
