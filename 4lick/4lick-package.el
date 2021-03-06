;; `(online?)` is a function that tries to detect whether you are online.
;; We want to refresh our package list on Emacs start if we are.
(require 'cl)
(defun online? ()
  (if (and (functionp 'network-interface-list)
           (network-interface-list))
      (some (lambda (iface) (unless (equal "lo" (car iface))
                         (member 'up (first (last (network-interface-info
                                                   (car iface)))))))
            (network-interface-list))
    t))


(setq package-user-dir (concat dotfiles-dir "elpa"))
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; To get the package manager going, we invoke its initialise function.
(package-initialize)

;; If we're online, we attempt to fetch the package directories if
;; we don't have a local copy already. This lets us start installing
;; packages right away from a clean install.
(when (online?)
  (unless package-archive-contents (package-refresh-contents)))

;; `Paradox' is an enhanced interface for package management, which also
;; provides some helpful utility functions we're going to be using
;; extensively. Thus, the first thing we do is install it if it's not there
;; already.
(when (not (package-installed-p 'paradox))
  (package-install 'paradox))

(when (not (package-installed-p 'use-package))
  (package-install 'use-package))

(when (not (package-installed-p 'quelpa))
  (package-install 'quelpa))

(quelpa
 '(quelpa-use-package
   :fetcher github
   :repo "quelpa/quelpa-use-package"
   :stable nil))
(require 'quelpa-use-package)

(require 'use-package)
(setq use-package-always-ensure t)

;; We're going to try to declare the packages each feature needs as we
;; define it. To do this, we define a function `(package-require)`
;; which will fetch and install a package from the repositories if it
;; isn't already installed. Eg. to ensure the hypothetical package
;; `ponies` is installed, you'd call `(package-require 'ponies)`.
;; This is just a wrapper for `paradox-require', which we might be using
;; directly except we don't right now.
(defun package-require (pkg)
  "Install a package only if it's not already installed."
  (paradox-require pkg))

(provide '4lick-package)
