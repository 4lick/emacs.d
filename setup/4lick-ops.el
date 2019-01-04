(require '4lick-package)
(require '4lick-lib)

;; Install terraform-mode
(use-package terraform-mode
  :init
  (custom-set-variables
   '(terraform-indent-level 4))
  :mode (("\\.tf\\'" . terraform-mode)
	 ("\\.tfvars\\'" . terraform-mode)))

(provide '4lick-ops)
