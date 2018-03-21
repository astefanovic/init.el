
(require 'package)
(package-initialize)

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
 '(chess-default-display (quote (chess-ics1 chess-plain chess-images)))
 '(chess-display-highlight-legal nil)
 '(explicit-shell-file-name "C:\\Program Files\\Git\\bin\\bash.exe")
 '(package-selected-packages
   (quote
    (speed-type chess rjsx-mode zenburn-theme google-this treemacs json-mode web-beautify emmet-mode web-mode linum omnisharp))))

;; Ensures packages are installed
;;(dolist (package '(rjsx-mode zenburn-theme google-this treemacs json-mode web-beautify emmet-mode web-mode))
(dolist (package package-selected-packages)
  (unless (package-installed-p package)
    (package-refresh-contents)
    (package-install package))
  (require package))

;;; Use UTF-8
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(setq locale-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8-unix)

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
;; No toolbar and scrollbar
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Save open files on exit
(desktop-save-mode 1)
;; Line Numbers
(global-linum-mode 1)

;; Web-mode modes
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))

;; Omnisharp mode
(add-hook 'csharp-mode-hook 'omnisharp-mode)

;; For "Bash subsystem for Windows"
;; Sets the shell to bash
;; (setenv "PID" nil)
;; (defun my-shell-setup ()
;;        "For Cygwin bash under Emacs 25"
;;        (setq comint-scroll-show-maximum-output 'this)
;;        (make-variable-buffer-local 'comint-completion-addsuffix))
;;        (setq comint-completion-addsuffix t)
;;        ;; (setq comint-process-echoes t) ;; reported that this is no longer needed
;;        (setq comint-eol-on-send t)
;;        (setq w32-quote-process-args ?\")
;;(add-hook 'shell-mode-hook 'my-shell-setup)

;; Backups go into .saves
(setq backup-directory-alist `(("." . "~/.saves")))
(global-auto-revert-mode t)
