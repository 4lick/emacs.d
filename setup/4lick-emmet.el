(use-package emmet-mode
  :commands emmet-mode
  :bind ("C-c n e" . emmet-mode)
  :init
  (progn
    (add-hook 'sgml-mode-hook 'emmet-mode)
    (add-hook 'html-mode-hook 'emmet-mode)
    (add-hook 'css-mode-hook 'emmet-mode))
  :ensure t)

(provide '4lick-emmet)
