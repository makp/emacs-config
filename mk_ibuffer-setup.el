;;; The intuition behind *ibuffer* is to have a buffer menu that lets
;;; you operate on buffers much in the same manner as Dired.

(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-auto-mode 1))) ;auto-update
(setq
 ibuffer-show-empty-filter-groups nil ;; don't show empty filter groups
 ibuffer-expert t ;; don't ask for confirmation of "dangerous" operations.
 ibuffer-filter-group-name-face 'font-lock-variable-name-face ;;
 ibuffer-old-time 50)

(require 'ibuf-ext)
(dolist (ibfilter '("^\\*" "_region_"))
  (add-to-list 'ibuffer-never-show-predicates ibfilter))

;; ibuffer mode maps
(define-key ibuffer-mode-map "l" (lambda ()
				   (interactive)
				   (call-interactively 'ace-jump-line-mode)))

(define-key ibuffer-mode-map (kbd "U") 'ibuffer-unmark-all)
;;; to be consistent with dired-mode. It was ibuffer.*regexp

(defun mk/open-magit-status-from-ibuffer ()
  (interactive)
  (ibuffer-visit-buffer)
  (call-interactively 'magit-status))

(define-key ibuffer-mode-map (kbd "g") 'mk/open-magit-status-from-ibuffer)

;; Use human readable size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000) (format "%7.3fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000000) (format "%7.3fM" (/ (buffer-size) 1000000.0)))
   (t (format "%8d" (buffer-size)))))

;; ibuffer-vc
(require 'ibuffer-vc)

(add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-vc-set-filter-groups-by-vc-root)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic))))

;; Type '`' to switch through different ibuffer-formats
(setq ibuffer-formats
      '((mark modified read-only vc-status-mini " "
              (name 18 18 :left :elide)
              " "
              (size-h 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              (vc-status 16 16 :left)
              " "
              filename-and-process)
	(mark modified read-only vc-status-mini " "
              (name 18 18 :left :elide)
              " "
              (size-h 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              (vc-status 16 16 :left))))

;; (eval-after-load 'ibuffer '(require 'ibuffer-git))

;; (setq ibuffer-formats
;;       '((mark modified read-only git-status-mini " "
;;  	      (name 18 18 :left :elide)
;;  	      " "
;;  	      (size-h 9 -1 :right)
;;  	      " "
;;  	      (mode 16 16 :left :elide)
;;  	      " "
;;  	      (git-status 8 8 :left)
;;  	      " " filename-and-process)))



;; (setq ibuffer-saved-filter-groups
;;       (quote (("default"      
;; 	       ("agendas"
;; 		 (filename . "/home/makmiller/elisp/agendas/"))
;; 	       ("other org files" 
;; 		(mode . org-mode))
;; 	       ("LaTeX"
;; 		(or 
;; 		 (mode . latex-mode)
;; 		 (mode . bibtex-mode)))
;; 	       ("scripting"
;; 		(or
;; 		 (mode . conf-mode) 	; not working
;; 		 (mode . term-mode)
;; 		 (mode . perl-mode)
;; 		 (mode . sh-mode)
;; 		 (mode . conf-xdefaults-mode)
;; 		 (mode . emacs-lisp-mode)))
;; 	       ("programming"
;; 		(or
;; 		 (mode . html-mode)
;; 		 (mode . web-mode)
;; 		 (mode . c-mode)
;; 		 (mode . haskell-mode)
;; 		 (mode . lisp-mode)
;; 		 (mode . python-mode))) 
;; 	       ("PDFs"
;; 		(or
;; 		 (mode . doc-view-mode)
;; 		 (mode . pdf-view-mode)))
;; 	       ("ERC"
;; 		(mode . erc-mode))
;; 	       ("info"
;; 		(mode . info-mode))
;; 	       ("dired"
;; 		(or
;; 		 (mode . dired-mode)))))))

;; (add-hook 'ibuffer-mode-hook
;; 	  (lambda ()
;; 	    (ibuffer-switch-to-saved-filter-groups "default")))



;; ;;;###autoload
;; (defun ibuffer-ediff-marked-buffers ()
;;   (interactive)
;;   (let* ((marked-buffers (ibuffer-get-marked-buffers))
;;          (len (length marked-buffers)))
;;     (unless (= 2 len)
;;       (error (format "%s buffer%s been marked (needs to be 2)"
;;                      len (if (= len 1) " has" "s have"))))
;;     (ediff-buffers (car marked-buffers) (cadr marked-buffers))))

;; (define-key ibuffer-mode-map "e" 'ibuffer-ediff-marked-buffers)

(provide 'mk_ibuffer-setup)
