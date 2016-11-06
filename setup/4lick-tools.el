(require '4lick-package)

;; restclient
(use-package restclient
  :mode ("\\.es\\'" . restclient-mode))

;; docker
(use-package dockerfile-mode
  :mode ("Dockerfile\\'" . dockerfile-mode))

(use-package docker)  

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(provide '4lick-tools)
