(server-start)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(package-refresh-contents)
(package-initialize)

(package-install 'use-package)

(eval-when-compile
  (require 'use-package))


  ;; set coding environment
(set-language-environment "UTF-8")

(global-set-key "\C-ca" 'org-agenda)
;;(setq org-log-done 'time)

;; add more packages, needed for org-roam
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))


(setq org-agenda-files (list "~/Workspace/org-roam"))

;; add file to a register C-x r j t to open
(set-register ?i (cons 'file "~/Workspace/org-roam/20200610123926-index.org"))
(set-register ?t (cons 'file "~/Workspace/org-roam/20200610130711-payvision_tasks.org"))

(setq fill-column 80)

;; config org-roam
;;(setq org-roam-directory "~/Workspace/org-roam")
(require 'use-package)

(use-package org-download
  
  :after org
  :bind
  (:map org-mode-map
   (("s-Y" . org-download-screenshot)
    ("s-y" . org-download-yank)))
  :ensure t
  :init
     (setq org-download-image-dir "./img/")
     (setq org-download-heading-lvl nil)
     (setq org-download-image-html-width 750))


;; move-text bindings
(use-package move-text
  :ensure t
  :init (move-text-default-bindings))

;; magit
(use-package magit
  :ensure t)


;; for auto update packages every 4 day
(use-package auto-package-update
   :ensure t
   :config
   (setq auto-package-update-delete-old-versions t
         auto-package-update-interval 4)
   (auto-package-update-maybe))

;; IDE
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

;; Optional - provides fancier overlays.
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
  :ensure t
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :config
  ;; Optionally enable completion-as-you-type behavior.
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))


(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;; Optional - provides snippet support.
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))


;; Go IDE
(use-package go-mode
  :ensure t)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)


;; js mode
(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode)

;; yaml mode
(use-package yaml-mode
  :ensure t
  :mode (("\\.yml$" . yaml-mode)
	 ("\\.yaml$" . yaml-mode)))

;; markdown-mode
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown.exe"))

;; dockerfile-mode
(use-package dockerfile-mode
  :ensure t
  :mode (("Dockerfile\\'" . dockerfile-mode)))
