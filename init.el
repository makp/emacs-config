;;; init.el --- Initialization file

;;; Commentary:

;; 

;;; Code:

;; =========
;; Load path
;; =========
(add-to-list 'load-path "~/elisp/")
(add-to-list 'load-path "~/config-files/general/emacs-configs/")

;; ===========
;; core config
;; ===========
(require 'mk_packages)
(require 'mk_better-defaults)
(require 'mk_helm-setup)
(require 'mk_registers)
(require 'mk_windows-setup)
(require 'mk_buffers-setup)
(require 'mk_session-management)
(require 'mk_magit)
(require 'mk_misc-functions)
(require 'mk_mark-setup)
(require 'mk_mode-line)

;; =================
;; eval-after-load's
;; =================
(with-eval-after-load 'cc-mode
  (require 'mk_cc))
(with-eval-after-load 'elisp-mode
  (require 'mk_elisp))
(with-eval-after-load 'tex-mode
  (require 'mk_latex))
(with-eval-after-load 'python
  (require 'mk_python))
(with-eval-after-load 'dired
  (require 'mk_dired))
(with-eval-after-load 'ibuffer
  (require 'mk_ibuffer-setup))


;; =======
;; modules
;; =======
(global-set-key (kbd "<f5>")
		'(lambda ()
		   (interactive)
		   (require 'mk_company)
		   (require 'mk_yasnippet-setup)
		   (require 'mk_orgmode-setup)
		   (require 'mk_evil)
		   (require 'mk_eww)
		   (pdf-tools-install)))

(global-set-key (kbd "<f6>")
		'(lambda ()
		   (interactive)
		   (require 'mk_web-devel)
		   (require 'mk_keyfreq)))

;; Custom set vars below this line
