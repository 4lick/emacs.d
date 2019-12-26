(require '4lick-package)

(use-package org
  :ensure t
  :defer t
  ;;:init (setq initial-major-mode 'org-mode) ;; Set mode of *scratch* buffer
  :bind (("C-c l" . org-store-link)
         ("C-c c" . org-capture)
	 ;;("C-c i" . 'org-iswitchb)         	 
         ("C-c a" . org-agenda)
         :map org-mode-map
         ("C-c !" . org-time-stamp-inactive))
  :mode ("\\.org$" . org-mode))

(setq org-agenda-files (quote ("~/org/todo")))

;;(use-package org-pomodoro
;;  :bind (("C-c C-^" . org-clock-in)
;;	 ("C-c C-ù" . org-clock-out)))

(defun 4lick/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (hide-other)
    (org-cycle)
    (org-cycle)
    (org-cycle)))

(defun 4lick/set-truncate-lines ()
  "Toggle value of truncate-lines and refresh window display."
  (interactive)
  (setq truncate-lines (not truncate-lines))
  ;; now refresh window display (an idiom from simple.el):
  (save-excursion
    (set-window-start (selected-window)
                      (window-start (selected-window)))))

(defun 4lick/make-org-scratch ()
  (interactive)
  (find-file "/tmp/publish/scratch.org")
  (gnus-make-directory "/tmp/publish"))


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "light green" :weight bold))))

;;(setq org-use-fast-todo-selection t)
;;
;;(setq org-treat-S-cursor-todo-selection-as-state-change nil)

;;(setq org-todo-state-tags-triggers
;;      (quote (("CANCELLED" ("CANCELLED" . t))
;;              ("WAITING" ("WAITING" . t))
;;              ("HOLD" ("WAITING") ("HOLD" . t))
;;              (done ("WAITING") ("HOLD"))
;;              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
;;              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
;;              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(setq org-directory "~/org")
(setq org-default-notes-file "~/org/refile.org")

;; Capture templates for: TODO tasks, Notes, ... and org-protocol
;;(setq org-capture-templates
;;      (quote (("t" "Todo" entry (file "~/org/refile.org")
;;               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
;;              ("r" "Respond" entry (file "~/git/org/refile.org")
;;               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
;;              ("n" "Note" entry (file "~/org/refile.org")
;;               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
;;              ("j" "Journal" entry (file+datetree "~/org/diary.org")
;;               "* %?\n%U\n" :clock-in t :clock-resume t)
;;              ("w" "Org-protocol" entry (file "~/org/refile.org")
;;               "* TODO Review %c\n%U\n" :immediate-finish t)
;;              ;;("m" "Meeting" entry (file "~/org/refile.org")
;;              ;; "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
;;              ;;("p" "Phone call" entry (file "~/org/refile.org")
;;              ;; "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
;;              ("h" "Habit" entry (file "~/org/refile.org")
;;               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

(setq org-global-properties
              '(("Effort_ALL". "0 0:10 0:30 1:00 2:00 3:00 4:00")))


(provide '4lick-org-mode)


