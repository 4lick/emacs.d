;; helm

(use-package helm
  :config
  (require 'helm-config)
  (require 'helm)
  ;; Activate Helm.
  (helm-mode 1)
  (with-eval-after-load "4lick-project"
    (use-package helm-projectile
      ;; A binding for using Helm to pick files using Projectile,
      ;; and override the normal grep with a Projectile based grep.
      :bind (("C-c C-f" . helm-projectile-find-file-dwim)
             ("C-x C-g" . helm-projectile-grep))))
  ;; Tell Helm to resize the selector as needed.
  (helm-autoresize-mode 1)
  ;; Make Helm look nice.
  (setq-default helm-display-header-line nil
                helm-autoresize-min-height 10
                helm-autoresize-max-height 35
                helm-split-window-in-side-p t

                helm-M-x-fuzzy-match t
                helm-buffers-fuzzy-matching t
                helm-recentf-fuzzy-match t
                helm-apropos-fuzzy-match t)
  (set-face-attribute 'helm-source-header nil :height 0.75)

  ;; custum style
  (set-face-attribute 'helm-selection nil 
                      :background "orange"
                      :foreground "black")
    
  ;; Replace common selectors with Helm versions.
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x C-g" . helm-do-grep)
         ;;("C-x b" . helm-buffers-list) ;; use ido-virtual-buffers
	 ("C-x b" . helm-mini) ;; uses recentf
         ("C-x c g" . helm-google-suggest)
         ("C-t" . helm-imenu)
	 ("C-c h o" . helm-occur)
         ("M-y" . helm-show-kill-ring)))

;; Enrich isearch with Helm using the `C-S-s' binding.
;; swiper-helm behaves subtly different from isearch, so let's not
;; override the default binding.
(use-package swiper-helm
  :bind (("C-S-s" . swiper-helm)))

;; Bind C-c C-e to open a Helm selection of the files in your .emacs.d.
;; We get the whole list of files and filter it through `git check-ignore'
;; to get rid of transient files.
(defun 4lick-helm/gitignore (root files success error)
  (let ((default-directory root))
    (let ((proc (start-process "gitignore" (generate-new-buffer-name "*gitignore*")
                               "git" "check-ignore" "--stdin"))
          (s (lambda (proc event)
               (if (equal "finished\n" event)
                   (funcall success
                            (with-current-buffer (process-buffer proc)
                              (s-split "\n" (s-trim (buffer-string)))))
                 (funcall error event))
               (kill-buffer (process-buffer proc))
               (delete-process proc))))
      (set-process-sentinel proc s)
      (process-send-string proc (concat (s-join "\n" files) "\n"))
      (process-send-eof proc))))

(defun 4lick-helm/files-in-repo (path success error)
  (let ((files (f-files path nil t)))
    (4lick-helm/gitignore path files
                         (lambda (ignored)
                           (funcall success (-difference files ignored)))
                         error)))

(defun 4lick-helm/find-files-in-emacs-d ()
  (interactive)
  (4lick-helm/files-in-repo
   dotfiles-dir
   (lambda (files)
     (let ((relfiles (-filter
                      (lambda (f) (not (f-descendant-of? f ".git")))
                      (-map (lambda (f) (f-relative f dotfiles-dir)) files))))
       (find-file
        (concat dotfiles-dir
                (helm :sources (helm-build-sync-source ".emacs.d" :candidates relfiles)
                      :ff-transformer-show-only-basename helm-ff-transformer-show-only-basename
                      :buffer "*helm emacs.d*")))))
   (lambda (err) (warn "4lick-helm/find-files-in-emacs-d: %s" err))))

(global-set-key (kbd "C-c C-e") '4lick-helm/find-files-in-emacs-d)



(provide '4lick-helm)
;;; 4lick-helm.el ends here
