
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


(setq org-agenda-files "~/Workspace/org-roam")
(setq fill-column 80)

;; config org-roam
;;(setq org-roam-directory "~/Workspace/org-roam")
(require 'use-package)
(use-package org-roam
  :ensure t
  :hook
  (after-init . org-roam-mode)
    :custom
    (org-roam-directory  "~/Workspace/org-roam")
    (org-roam-index-file "~/Workspace/org-roam/20200610123926-index.org")
    (org-roam-graph-executable "C:\ProgramData\chocolatey\bin\dot.exe")
    :init
    (add-hook 'text-mode-hook 'turn-on-auto-fill)
    :bind (:map org-roam-mode-map
    (("C-c n l" . org-roam)
    ("C-c n f" . org-roam-find-file)
    ("C-c n g" . org-roam-show-graph)
    ("C-c n n" . org-roam-jump-to-index))
    :map org-mode-map
    (("C-c n i" . org-roam-insert))))

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

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown.exe"))

;; config docker mode
;; https://github.com/spotify/dockerfile-mode
;;(add-to-list 'load-path "~/.emacs.d/dockerfile-mode/")
;;(require 'dockerfile-mode)
;;(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(use-package dockerfile-mode
  :ensure t
  :mode (("Dockerfile\\'" . dockerfile-mode)))

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


;; Go IDE
(use-package go-mode
  :ensure t)

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Optional - provides fancier overlays.
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
  :ensure t
  :config
  ;; Optionally enable completion-as-you-type behavior.
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

;; Optional - provides snippet support.
(use-package yasnippet
  :ensure t
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

;; yaml mode
(use-package yaml-mode
  :ensure t
  :mode (("\\.yml$" . yaml-mode)
	 ("\\.yaml$" . yaml-mode)))
