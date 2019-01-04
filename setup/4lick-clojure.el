(use-package auto-complete
  :diminish auto-complete-mode
  :config
  (ac-config-default)
  (eval '(progn (ac-set-trigger-key "TAB")
                (ac-flyspell-workaround)))
  (setq ac-auto-start nil))

(use-package ac-capf
  :config (ac-capf-setup))

(use-package paredit
  :diminish paredit-mode
  :config
  (dolist (hook '(clojure-mode-hook
                  cider-repl-mode-hookk))
    (add-hook hook 'enable-paredit-mode)))

(use-package paredit-everywhere
  :diminish paredit-everywhere-mode
  :config (add-hook 'prog-mode-hook 'paredit-everywhere-mode))

;;(use-package rainbow-delimiters
;;  :ensure
;;  :init
;;  (progn
;;    (add-hook 'emacs-lisp-mode-hook (lambda()
;;                      (rainbow-delimiters-mode t)))))

(use-package cider
  :ensure t
  :config
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'eldoc-mode)
  (add-hook 'cider-repl-mode-hook #'paredit-mode))
  ;;(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode))

;;(use-package cider
;;  :defer 1
;;  :config
;;  (setq cider-prompt-for-symbol nil
;;        cider-prompt-for-project-on-connect nil
;;        cider-repl-display-help-banner nil
;;        cider-repl-use-pretty-printing t)
;;  (add-hook 'cider-repl-mode-hook 'eldoc-mode)
;;  (bind-keys :map cider-repl-mode-map
;;             ("C-c M-o" . cider-repl-clear-buffer)))

(use-package clojure-mode-extra-font-locking
  :ensure t)

(use-package ac-cider
  :defer t
  :init
  (dolist (hook '(cider-mode-hook cider-repl-mode-hook))
    (add-hook hook 'ac-cider-setup))
  (dolist (mode '(cider-mode cider-repl-mode))
    (add-to-list 'ac-modes mode)))

;; key bindings
;; these help me out with the way I usually develop web apps
(defun cider-start-http-server ()
  (interactive)
  (cider-load-current-buffer)
  (let ((ns (cider-current-ns)))
    (cider-repl-set-ns ns)
    (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
    (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))


(defun cider-refresh ()
  (interactive)
  (cider-interactive-eval (format "(user/reset)")))

(defun cider-user-ns ()
  (interactive)
  (cider-repl-set-ns "user"))

(eval-after-load 'cider
  '(progn
     (define-key clojure-mode-map (kbd "C-c C-v") 'cider-start-http-server)
     (define-key clojure-mode-map (kbd "C-M-r") 'cider-refresh)
     (define-key clojure-mode-map (kbd "C-c u") 'cider-user-ns)
     (define-key cider-mode-map (kbd "C-c u") 'cider-user-ns)))

(provide '4lick-clojure-reload)

;;(use-package clojure-mode :ensure t
;;   :init (progn
;;           (setq buffer-save-without-query t)
;;           (add-hook 'clojure-mode-hook
;;                     (lambda ()
;;                       (push '("partial" . ?Ƥ) prettify-symbols-alist)
;;                       (push '("comp" . ?ο) prettify-symbols-alist)
;;                       (lisp-mode-setup))))
;;   :mode (("\\.cljs$" . clojure-mode)
;;          ("\\.cljx$" . clojure-mode)
;;          ("\\.edn$" . clojure-mode)
;;          ("\\.dtm$" . clojure-mode))
;;   :config (progn
;;             (diminish-major-mode 'clojure-mode "Cλ")
;;             (bind-key "C-c C-z" nil clojure-mode-map))) ; Remove the binding for inferior-lisp-mode
;; ;;
;; (use-package clojure-mode-extra-font-locking :ensure t)
;;
;; (use-package cider :ensure t
;;   :pin melpa-stable
;;   :init (progn
;;           (setq nrepl-hide-special-buffers nil
;;                 cider-repl-pop-to-buffer-on-connect nil
;;                 cider-prompt-for-symbol nil
;;                 nrepl-log-messages t
;;                 cider-popup-stacktraces t
;;                 cider-repl-popup-stacktraces t
;;                 cider-auto-select-error-buffer t
;;                 cider-repl-print-length 100
;;                 cider-repl-history-file (expand-file-name "cider-history" user-emacs-directory)
;;                 cider-repl-use-clojure-font-lock t
;;                 cider-switch-to-repl-command 'cider-switch-to-relevant-repl-buffer)
;;           (add-hook 'clojure-mode-hook 'cider-mode))
;;   :config (progn
;;             (diminish-major-mode 'cider-repl-mode "Ç»")
;;             (cider-turn-on-eldoc-mode)
;;             (add-to-list 'same-window-buffer-names "*cider*")
;;             (add-hook 'cider-repl-mode-hook 'lisp-mode-setup)
;;             (add-hook 'cider-connected-hook 'cider-enable-on-existing-clojure-buffers))
;;   :diminish " ç")
;;
;; (use-package eval-sexp-fu :ensure t
;;   :init (custom-set-faces '(eval-sexp-fu-flash ((t (:foreground "green4" :weight bold))))))
;;
;; (use-package cider-eval-sexp-fu :ensure t)
;;
;; (use-package clj-refactor :ensure t
;;   :init (add-hook 'clojure-mode-hook (lambda ()
;;                                        (clj-refactor-mode 1)
;;                                        (cljr-add-keybindings-with-prefix "C-c M-r")))
;;   :diminish "")
;;
;; (use-package cljsbuild-mode :ensure t)
;;
;; (use-package slamhound :ensure t)
;;
;; (use-package latest-clojure-libraries :ensure t)
;;
;; (provide '4lick-clojure-reload)
