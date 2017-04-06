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

;; merge tools
;; https://help.github.com/articles/resolving-a-merge-conflict-from-the-command-line/
;; http://emacs.stackexchange.com/questions/5507/how-to-start-ediff-ing-a-file-that-has-git-conflict-markers-in-it
;; http://emacs.stackexchange.com/questions/16469/how-to-merge-git-conflicts-in-emacs
;; smerge-next bound to smerge-command-prefixn to move to next conflict.
;; smerge-previous bound to smerge-command-prefixp to move to previous conflict.
;; smerge-keep-current bound to smerge-command-prefixRET to keep the version the cursor is on.
;; smerge-keep-mine bound to smerge-command-prefixm to keep your changes.
;; smerge-keep-other bound to smerge-command-prefixo to keep other changes.

;; smerge-ediff bound to smerge-command-prefix E
;; # Keybindings
;; Navigate through the conflicts with n and p .
;; Accept versions with a or b .
;; Look at the ancestor with / !
;; Quit the ediff session with q .

(provide '4lick-tools)
