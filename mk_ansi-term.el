;; =================
;; pop-up ansi-terms
;; =================
(defun mk/ansi-term-popup ()
  "Toggle an ansi-term buffer."
  (interactive)
  (when (not (get-buffer "*ansi-term*"))
      (save-window-excursion (ansi-term (getenv "SHELL"))))
  (if (equal (buffer-name) "*ansi-term*")
      (quit-window)
    (switch-to-buffer-other-window "*ansi-term*")))

(defun mk/chama-ansi-term (&optional arg)
  "Function to call ansi-term. With a prefix argument, call a new
  instance of ansi-term"
  (interactive "P")
  (if (not (consp arg))
      (mk/ansi-term-popup)
    (ansi-term "/bin/zsh")))

(define-key my-keys-minor-mode-map (kbd "C-x C-p") 'mk/chama-ansi-term)

(provide 'mk_ansi-term)
;;; mk-shell ends here