(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
             
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
  
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(explicit-shell-file-name "C:\\Windows\\System32\\bash.exe")
 '(package-selected-packages
   (quote
    (rjsx-mode zenburn-theme google-this treemacs json-mode web-beautify emmet-mode web-mode))))

;; Ensures packages are installed
(dolist (package '(rjsx-mode zenburn-theme google-this treemacs json-mode web-beautify emmet-mode web-mode))
 (unless (package-installed-p package)
   (package-install package))
   (require package))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 
;; User added modes below
;; This shit dont work for windows
;;(add-to-list 'default-frame-alist
;;                       '(font . "Source Code Pro-12"))
(setf (alist-get "\\.js\\'" auto-mode-alist) 'rjsx-mode)
(load-theme 'zenburn t)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(desktop-save-mode 1)

;; Sets the shell to bash
(setenv "PID" nil)
(defun my-shell-setup ()
       "For Cygwin bash under Emacs 25"
       (setq comint-scroll-show-maximum-output 'this)
       (make-variable-buffer-local 'comint-completion-addsuffix))
       (setq comint-completion-addsuffix t)
       ;; (setq comint-process-echoes t) ;; reported that this is no longer needed
       (setq comint-eol-on-send t)
       (setq w32-quote-process-args ?\")
     
(add-hook 'shell-mode-hook 'my-shell-setup)
;; Backups go into .saves
(setq backup-directory-alist `(("." . "~/.saves")))
(global-auto-revert-mode t)
