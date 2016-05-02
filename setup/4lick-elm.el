(require '4lick-package)

(use-package flycheck-elm
    :defer t
    :init (add-hook 'flycheck-mode-hook #'flycheck-elm-setup))
    :config
    (use-package elm-mode
        :mode ("\\.elm\\'" . elm-mode)
        :init
        (add-hook 'elm-mode-hook
          (lambda ()
            (setq company-backends '(company-elm))))
            ;;(set (make-local-variable 'company-backends) '(company-elm))))
        (add-hook 'elm-mode-hook #'elm-oracle-setup-completion))

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
    (setq exec-path (append exec-path '("/usr/local/bin")))

(provide '4lick-elm)
