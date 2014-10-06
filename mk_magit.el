;;; version control
(autoload 'magit-status "magit" nil t)

(global-set-key (kbd "C-x p") (lambda ()
				(interactive)
				(let ((current-prefix-arg '(4)))
				  (call-interactively
				   'magit-status))
				(call-interactively 'magit-pull)))

(global-set-key (kbd "C-x d") 'helm-ls-git-ls) 	;helm-browse-project

(global-set-key (kbd "C-x C-d") (lambda ()
				(interactive)
				(let ((current-prefix-arg '(4)))
				  (call-interactively
				   'magit-status))
				(call-interactively 'helm-ls-git-ls)))

(global-set-key (kbd "C-x t") (lambda ()
				(interactive)
				(let ((current-prefix-arg '(4)))
				  (call-interactively
				   'magit-status))
				(call-interactively 'helm-find-files)))

(global-set-key (kbd "C-x o") 'magit-status)

(setq magit-diff-refine-hunk 'all)

;; (add-hook 'magit-log-edit-mode-hook
;; 	  (lambda ()
;; 	    (orgstruct-mode)))

(setq magit-repo-dirs '("~/elisp/agendas"
			"~/config-files/general"
			"~/scripts/myscripts"
			"~/Documents/mydocs"))

;;; With one prefix argument, magit will provide magit-repo-dirs for
;;; you to complete. If you want to create a new repository, use two
;;; prefix-args.

(provide 'mk_magit)
