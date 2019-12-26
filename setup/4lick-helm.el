;; helm
(use-package helm
  :config
  (require 'helm-config)
  (require 'helm)
  
  ;;(setq helm-ff-transformer-show-only-basename nil
  ;;      ;;helm-adaptive-history-file             ers-helm-adaptive-history-file
  ;;      helm-boring-file-regexp-list           '("\\.git$" "\\.svn$" "\\.elc$")
  ;;      helm-yank-symbol-first                 t
  ;;      helm-buffers-fuzzy-matching            t
  ;;      helm-ff-auto-update-initial-value      t
  ;;      helm-input-idle-delay                  0.1
  ;;      helm-idle-delay                        0.1)
  ;;
  ;;:init (progn
  ;;      (require 'helm-config)
  ;;      (helm-mode t)
  ;;      ;;(helm-adaptative-mode t)
  ;;

  ;;(use-package helm-ag
  ;;        :ensure    helm-ag
  ;;        :bind      ("C-c a" . helm-ag))
  
  ;;(use-package helm-descbinds
  ;;  :ensure    helm-descbinds
  ;;  :bind      ("C-h b" . helm-descbinds))

  (use-package helm-swoop
     :ensure    helm-swoop
     :bind      (("C-x c s" . helm-swoop)))
          
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
         ;;("C-x C-g C-g" . helm-do-grep)         
  	 ("C-x b"   . helm-mini) 
         ("C-t"     . helm-imenu)
  	 ("C-c h o" . helm-occur)	 
         ("M-y"     . helm-show-kill-ring)
         ;;("C-x r l" . helm-bookmarks)
         ;;("C-x c g" . helm-google-suggest)	 
         ;;("C-h a"   . helm-apropos)
         ("C-x p" .   helm-top)
	 :map helm-map
	 ("<left>" . helm-find-files-up-one-level)	 	 
	 ("<right>" . helm-execute-persistent-action)))

;; Enrich isearch with Helm using the `C-S-s' binding.
;; swiper-helm behaves subtly different from isearch, so let's not
;; override the default binding.
(use-package swiper-helm
  :bind (("C-S-s" . swiper-helm)))

(provide '4lick-helm)

