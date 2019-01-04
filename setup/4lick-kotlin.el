(require '4lick-package)

;; Kotlin
(use-package kotlin-mode
  :mode ("\\.kt\\'" . kotlin-mode)
  :init
  (add-hook 'kotlin-mode-hook 'flycheck-mode))

(provide '4lick-kotlin)
