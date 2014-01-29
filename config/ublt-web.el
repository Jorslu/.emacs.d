(require 'ublt-util)


;;; Mix-language files

;; ;; Might be useful for f*cks like PHP, JSP, ASP.NET, mako, rhtml, django
;; (ublt/add-path "nxhtml/")
;; (add-hook 'nxhtml-mode-hook (lambda () (rng-validate-mode -1)))
;; (load "autostart.el")
;; (add-to-list 'auto-mode-alist '("\\.mako?$" . mako-nxhtml-mumamo-mode))
;; (add-hook 'mako-nxhtml-mumamo-mode-hook 'esk-turn-on-hl-line-mode)
;; (add-hook 'nxhtml-mode-hook (ublt/off-fn 'auto-fill-mode))
;; (add-hook 'nxhtml-mode-hook (ublt/off-fn 'flyspell-mode))

;;; FIX: This must be before web-mode is loaded, which is weird
(setq web-mode-extra-comment-keywords '("NTA" "FIX" "XXX"))
(ublt/set-up 'web-mode
  ;; `web-mode' doesn't highlight correctly if `font-lock-mode' is on.
  ;; Weird
  (add-hook 'web-mode-hook (ublt/off-fn 'font-lock-mode))
  (add-hook 'web-mode-hook (ublt/off-fn 'auto-fill-mode))
  (setq web-mode-script-padding 0
        web-mode-style-padding 2
        web-mode-enable-current-element-highlight t
        web-mode-enable-block-face t
        web-mode-enable-part-face t
        web-mode-enable-comment-keywords t
        ;; Auto-close when "</" is typed
        web-mode-tag-auto-close-style 1)
  (add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mako?$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.underscore$" . web-mode)))


;; Emmet (Zen-coding)

(ublt/set-up 'emmet-mode
  (setq emmet-preview-default nil)
  (defun ublt/set-up-emmet ()
    (emmet-mode +1)
    ;; Dynamic indentation after expansion based on tab width
    (set (make-local-variable 'emmet-indentation) tab-width))
  (dolist (m '(sgml-mode-hook
               html-mode-hook
               css-mode-hook
               less-css-mode-hook
               web-mode-hook))
    (add-hook m 'ublt/set-up-emmet)))


;;; Misc

;;; TODO: Paredit for css/less

(ublt/set-up 'less-css-mode
  (add-hook 'less-css-mode-hook 'esk-prog-mode-hook))

(ublt/set-up 'css-mode
  (add-hook 'css-mode-hook 'esk-prog-mode-hook)
  (setq css-indent-offset 2))

(ublt/set-up 'sgml-mode
  (add-hook 'html-mode-hook (ublt/off-fn 'auto-fill-mode)))

;;; XXX
(ublt/set-up 'php-mode
  (setq php-mode-coding-style nil)
  (add-hook 'php-mode-hook (lambda () (setq c-basic-offset 4))))

(provide 'ublt-web)
