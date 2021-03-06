(require '4lick-package)

;; Install Projectile and activate it for all things.
;; Learn about Projectile: http://batsov.com/projectile/
(use-package projectile
    :init (progn
          (projectile-global-mode)
          (setq projectile-enable-caching t)
          (setq projectile-ignored-directories  '("Godeps" "_output" "elpa" "node_modules"))
          (setq projectile-ignored-files '(".DS_Store" ".gitmodules" ".gitignore" "pkg")))
  :demand t
  :commands projectile-global-mode
  :config
  (projectile-global-mode)
  ;; Use C-c C-f to find a file anywhere in the current project.
  :bind (("C-c C-f" . projectile-find-file)
         ("<f1>"    . projectile-switch-project)
	 :map projectile-mode-map
	 ("s-p" . projectile-command-map)
	 ("C-c p" . projectile-command-map)))
  
(provide '4lick-project)
