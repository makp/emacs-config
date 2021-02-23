;;; mk_helm-setup.el --- Custom setup for Helm

;;; Commentary:

;; TODO:
;; - Remove certain types of files from tags search such as _region_.tex.

;;; Code:


;;; helm setup

;; (require 'helm-config)
;; (require 'helm-match-plugin)
;;; These two lines seem unecessary since I'm using MELPA.

(helm-mode 1)
(helm-adaptive-mode 1)
(helm-autoresize-mode 1)


;; =========
;; Helm vars
;; =========
(setq-default helm-external-programs-associations
	      '(("pdf" . "okular")
		("djvu" . "okular")
		("docx" . "libreoffice")
		("doc" . "libreoffice")
		("rtf" . "libreoffice")
		("svg" . "inkscape")
		("mp4" . "mplayer")
		("nb" . "mathematica")
		("wl" . "mathematica"))
	      helm-pdfgrep-default-read-command "okular --unique -p %p '%f'"
	      helm-input-idle-delay 0.01
	      ;; be idle for this many seconds, before updating. Safe value is
	      ;; always >= `helm-idle-delay'.
	      helm-idle-delay 0.01
	      ;; helm-delete-minibuffer-contents-from-point t
	      helm-move-to-line-cycle-in-source nil
	      helm-locate-command "locate %s -e -A --regex %s"

	      helm-follow-mode-persistent t
	      helm-ff-auto-update-initial-value nil
	      helm-ff-transformer-show-only-basename t

	      ;; helm-mode-fuzzy-match t
	      ;; helm-completion-in-region-fuzzy-match t

	      ;; helm-buffers-fuzzy-matching t
	      ;; helm-lisp-fuzzy-completion t
	      helm-locate-fuzzy-match t
	      helm-M-x-fuzzy-match t
	      helm-imenu-fuzzy-match t
	      helm-apropos-fuzzy-match t

	      helm-candidate-number-limit 100
	      helm-autoresize-max-height 25

	      helm-ff-skip-boring-files t
	      helm-boring-file-regexp-list (append helm-boring-file-regexp-list '("_region_.*" "\\.git$"))
	      helm-buffers-favorite-modes (append helm-buffers-favorite-modes '(LaTeX-mode))
	      helm-boring-buffer-regexp-list
	      (append helm-boring-buffer-regexp-list
		      '("\\*Minibuf" "\\*magit" "\\*Help\\*" "\\*helm" "\\*Echo Area" "\\*Org todo\\*" "\\*Messages\\*" "\\*Ibuffer\\*" "_region_.*")))

;; ===========
;; Global maps
;; ===========
;; rebinding a few things to helm
(define-key global-map [remap apropos-command] 'helm-apropos)
(define-key global-map [remap bookmark-jump] 'helm-pp-bookmarks)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap execute-extended-command] 'helm-M-x)
(define-key global-map [remap jump-to-register] 'helm-register)

;;; locate
(defun mk/locate-with-helm (&optional arg)
  "Run locate in different folders (mydocs, pdfs, and home)
depending on the value of ARG."
  (interactive "p")
  (cond
   ((equal arg 1)  (helm-locate-with-db (expand-file-name "locate.db" "~/elisp"))) ; pdfs
   ((equal arg 4)  (helm-locate-with-db (expand-file-name "locate-mydocs.db" "~/elisp"))) ; ~/Documents/mydocs
   ((equal arg 16) (helm-locate-with-db (expand-file-name "locate-home.db" "~/elisp"))))) ; $HOME

;; ----------------------
;; searching within files
;; ----------------------
;; grep
(require 'wgrep-helm)			; wgrep allows you to edit grep buffers

;; tags
(defun mk/find-tags (&optional arg)
  "Select tag. When ARG is non-nil, ask user to select a particular repo."
  (interactive "P")
  (when (consp arg)
    (call-interactively 'magit-status))
  (call-interactively 'helm-etags-select))

;; ===============
;; helm local maps
;; ===============
;; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
;; (define-key helm-map (kbd "C-z") 'helm-select-action)
;; (define-key helm-map (kbd "C-x C-r") 'helm-toggle-visible-mark)
;; (define-key helm-map (kbd "C-x h") 'helm-quit-and-find-file)
;; (define-key helm-map (kbd "C-x C-a") 'helm-ff-run-switch-to-eshell)

;; ======
;; eshell
;; ======
;;; enable helm pcomplete
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map
                [remap eshell-pcomplete]
                'helm-esh-pcomplete)))

;;; enable helm eshell history
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map
                (kbd "M-p")
                'helm-eshell-history)))

;; fix completion after sudo (from helm wiki)
(defun pcomplete/sudo ()
  (let ((prec (pcomplete-arg 'last -1)))
    (cond ((string= "sudo" prec)
           (while (pcomplete-here*
                   (funcall pcomplete-command-completion-function)
                   (pcomplete-arg 'last) t))))))


(provide 'mk_helm-setup)

;;; mk_helm-setup.el ends here
