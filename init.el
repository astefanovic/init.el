;; To make omnisharp work, first download the server executable from omnisharp-roslyn,
;; the x86.zip file,_logservice unpack into C://omnisharp/

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
 '(ring-bell-function 'ignore)
 ;;'(global-company-mode t)
 ;;'(company-auto-complete t)
 '(company-auto-complete-chars (quote (32 41 46 62)))
 '(company-minimum-prefix-length 0)
 '(company-global-modes (quote (not emacs-lisp-mode)))
 '(explicit-shell-file-name "C:\\Program Files\\Git\\bin\\bash.exe")
 '(omnisharp-server-executable-path "C:\\omnisharp\\OmniSharp.exe")
 '(package-selected-packages
   (quote
    (flycheck helm yasnippet speed-type chess rjsx-mode zenburn-theme google-this treemacs json-mode web-beautify emmet-mode web-mode linum omnisharp company))))

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
 '(company-template-field ((t (:background "wheat4" :foreground "ivory")))))
 
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

;; Electric pair, automatically closes brackets
(electric-pair-mode 1)

;; Web-mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))

;; NXML-mode
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

;; Helm configs
(require 'helm-config)
(require 'helm-command)
(require 'helm-elisp)
(require 'helm-misc)

;; Flycheck mode hook
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Omnisharp mode
(add-hook 'csharp-mode-hook 'omnisharp-mode)

(eval-after-load
 'company
 '(add-to-list 'company-backends 'company-omnisharp))

;; Google-this binding
(global-set-key (kbd "C-x g") 'google-this-mode-submap)

;; Company-mode (popup) global hook
;;(add-hook 'after-init-hook 'global-company-mode)
;; Company-mode hook only on csharp mode, its annoying if constantly hooked
(add-hook 'csharp-mode-hook #'company-mode)

;; Kill all other buffers
(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer
          (delq (current-buffer)
                (remove-if-not 'buffer-file-name (buffer-list)))))

;; Go to definition (for c#)
(global-set-key (kbd "C-x e") 'omnisharp-go-to-definition)
;; Go to implementation (for c#)
(global-set-key (kbd "C-x w") 'omnisharp-find-implementations)
;; Go to previous mark position, set by omnisharp
(global-set-key (kbd "C-x j") 'pop-tag-mark)
;; Go to useages, ie go to references in Visual Studio
(global-set-key (kbd "C-x \\") 'omnisharp-helm-find-usages)

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

;; Powershell shell function
(defun run-powershell ()
  "Run powershell."
  (interactive)
  (async-shell-command "c:/windows/system32/WindowsPowerShell/v1.0/powershell.exe -Command -"
               nil nil))

;; Backups go into .saves
(setq backup-directory-alist `(("." . "~/.saves")))
(global-auto-revert-mode t)
