;; copy without selection
;; https://www.emacswiki.org/emacs/CopyWithoutSelection
(defun get-point (symbol &optional arg)
 "get the point"
 (funcall symbol arg)
 (point))

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
   (save-excursion
     (let ((beg (get-point begin-of-thing 1))
    	 (end (get-point end-of-thing arg)))
       (copy-region-as-kill beg end))))

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe 
	 (lambda()
	   (if (string= "shell-mode" major-mode)
	     (progn (comint-next-prompt 25535) (yank))
	   (progn (goto-char (mark)) (yank) )))))
	(if arg
	    (if (= arg 1)
		nil
	      (funcall pasteMe))
	  (funcall pasteMe))))

(defun copy-word (&optional arg)
      "Copy words at point into kill-ring"
       (interactive "P")
       (copy-thing 'backward-word 'forward-word arg)
       ;;(paste-to-mark arg)
       )

(defun copy-line (&optional arg)
 "Save current line into Kill-Ring without mark the line "
  (interactive "P")
  (copy-thing 'beginning-of-line 'end-of-line arg)
  ;;(paste-to-mark arg)
  )

(bind-key "C-c w" 'copy-word)
(bind-key "C-c l" 'copy-line)

(provide 'copy-without-selection)
