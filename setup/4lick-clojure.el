(use-package clojure-mode
  :commands clojure-mode
  :config
  ;; Setup
  (add-hook
   'clojure-mode-hook
   (lambda ()
     ;;(paredit-mode 1)
     (clj-refactor-mode 1)
     ;; We'll be using Monroe, a simple nREPL client. To use it, you'll need
     ;; to start an nREPL somewhere (running `lein repl' in your project should
     ;; do the trick) and run `M-x monroe' to connect to it and open a REPL
     ;; buffer.
     (use-package monroe
       :commands monroe
       :config
       (clojure-enable-monroe)
       :bind (
              ;; Rebind C-x C-e to eval through nREPL in clojure-mode buffers.
              :map clojure-mode-map
                   ("C-x C-e" . monroe-eval-expression-at-point)))
     ;; We'll also be using clj-refactor for refactoring support. The features
     ;; which require CIDER won't work with Monroe.
     (use-package clj-refactor
       :commands clj-refactor-mode
       :config
       ;; Define the keybinding prefix for clj-refactor commands.
       ;; From there, see https://github.com/clojure-emacs/clj-refactor.el#usage
       (cljr-add-keybindings-with-prefix "C-c C-m"))))
  ;; Monroe doesn't offer any completion support. Let's build on it to
  ;; add a company-mode backend which queries the connected nREPL for
  ;; completions.
  (with-eval-after-load "company"
    (defun monroe-eval-string (s callback)
      (monroe-send-eval-string
       s
       (lambda (response)
         (monroe-dbind-response
          response (id ns value err out ex root-ex status)
          (when ns (setq monroe-buffer-ns ns))
          (when value (funcall callback nil value))
          (when status
            (when (member "eval-error" status) (funcall callback ex nil))
            (when (member "interrupted" status) (funcall callback status nil))
            (when (member "need-input" status) (monroe-handle-input))
            (when (member "done" status) (remhash id monroe-requests)))))))

    (defun monroe-get-completions (word callback)
      (interactive)
      (monroe-eval-string
       (format "(complete.core/completions \"%s\")" word)
       (lambda (err s)
         (when (not err) (funcall callback (read-from-whole-string s))))))

    (defun company-monroe (command &optional arg &rest ignored)
      (interactive (list 'interactive))
      (cl-case command
        (interactive (company-begin-backend 'company-monroe))
        (prefix (and (eq major-mode 'clojure-mode)
                     (get-buffer "*monroe-connection*")
                     (company-grab-symbol)))
        (candidates
         (cons :async
               (lambda (callback)
                 (monroe-get-completions arg callback))))))
    (add-to-list 'company-backends 'company-monroe)))

;; We might need Paredit too if that's how you like it.
(use-package paredit
  :commands paredit-mode
  :diminish paredit-mode)

(provide '4lick-clojure)
