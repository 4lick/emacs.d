(require '4lick-package)

;; Install Projectile and activate it for all things.
;; Learn about Projectile: http://batsov.com/projectile/
(use-package projectile
  :demand t
  :commands projectile-global-mode
  :config
  (projectile-global-mode)
  ;; Use C-c C-f to find a file anywhere in the current project.
  :bind ("C-c C-f" . projectile-find-file)
  :diminish projectile-mode)

(provide '4lick-project)
