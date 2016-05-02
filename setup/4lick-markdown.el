;;; Markdown:

(require '4lick-package)

;; Install Markdown support.
(use-package markdown-mode
  :commands markdown-mode
  :mode (("\\.markdown$" . markdown-mode)
         ("\\.md$" . markdown-mode)))


  (provide '4lick-markdown)
