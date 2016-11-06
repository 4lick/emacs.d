;; Initialise the package system
(package-initialize)

;; Skip the default splash screen.
(setq inhibit-startup-message t)

;; Path to .emacs.d
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) (file-chase-links load-file-name))))

;; 4lick Emacs's libraries packages.
(add-to-list 'load-path (concat dotfiles-dir "4lick"))

;; Vendor libs
(add-to-list 'load-path (concat dotfiles-dir "vendor"))

;; Setup modules
(add-to-list 'load-path (concat dotfiles-dir "setup"))

;; Load the 4lick Emacs fundamentals.
(require '4lick-package)
(require '4lick-lib)
(require '4lick-ui)
(require '4lick-theme)

;; customizations
(load-file (concat dotfiles-dir "setup/4lick-editing.el"))
(load-file (concat dotfiles-dir "setup/4lick-navigation.el"))
(load-file (concat dotfiles-dir "setup/4lick-helm.el"))
(load-file (concat dotfiles-dir "setup/4lick-project.el"))
(load-file (concat dotfiles-dir "setup/4lick-flycheck.el"))
(load-file (concat dotfiles-dir "setup/4lick-complete.el"))
(load-file (concat dotfiles-dir "setup/4lick-dired.el"))
;;(load-file (concat dotfiles-dir "setup/4lick-git.el"))
(load-file (concat dotfiles-dir "setup/4lick-snippets.el"))
(load-file (concat dotfiles-dir "setup/4lick-markdown.el"))

;; lang
(load-file (concat dotfiles-dir "setup/4lick-format.el"))
(load-file (concat dotfiles-dir "setup/4lick-elm.el"))
(load-file (concat dotfiles-dir "setup/4lick-haskell.el"))
(load-file (concat dotfiles-dir "setup/4lick-clojure-reload.el"))
;;(load-file (concat dotfiles-dir "setup/4lick-clojure.el"))

;; web
(load-file (concat dotfiles-dir "setup/4lick-emmet.el"))
;;(load-file (concat dotfiles-dir "setup/4lick-html.el"))
;;(load-file (concat dotfiles-dir "setup/4lick-javascript.el"))
;;(load-file (concat dotfiles-dir "setup/4lick-js-web-mode.el"))

;; tools
(load-file (concat dotfiles-dir "setup/4lick-tools.el"))

;; Functions (load all files in defuns-dir)
(setq defuns-dir (concat dotfiles-dir "defuns"))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Mac OS X
(defconst *is-a-mac* (eq system-type 'darwin))
(when *is-a-mac*
  (setq default-input-method "MacOSX")
  (setq mac-command-modifier 'meta
        mac-option-modifier nil
        mac-allow-anti-aliasing t
        mac-command-key-is-meta t)
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
  (setq exec-path (append exec-path '("/usr/local/opt/lein"))))
;;(defconst *is-a-mac* (eq system-type 'darwin))
;;(when *is-a-mac*
;;  (setq default-input-method "MacOSX")
;;  (setq mac-command-modifier 'meta
;;	mac-option-modifier nil
;;	mac-allow-anti-aliasing t
;;	mac-command-key-is-meta t))

;; End int.el

;;(custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(package-selected-packages
;;   (quote
;;    (flycheck-elm flycheck-elm-setup elm-mode f use-package paradox))))
;;(custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; )
