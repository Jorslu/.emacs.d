(require 'ublt-util)

(require 'flymake)
;; (defun flymake-php-init ()
;;   (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
;;          (local (file-relative-name temp (file-name-directory buffer-file-name))))
;;     (list "php" (list "-f" local "-l"))))
;; (add-to-list 'flymake-err-line-patterns
;;   '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))
;; (add-hook 'php-mode-hook 'enable-flymake)

(defun ublt/flymake-err-at (pos)
  (let ((overlays (overlays-at pos)))
    (remove nil
            (mapcar (lambda (overlay)
                      (and (overlay-get overlay 'flymake-overlay)
                           (overlay-get overlay 'help-echo)))
                    overlays))))

(defface ublt/flymake-message-face
  `((t (:inherit font-lock-keyword-face)))
  "Face for flymake message echoed in the minibuffer.")
(defun ublt/flymake-err-echo ()
  "Echo flymake error message in the minibuffer (not saving to *Messages*)."
  (ublt/status-message "%s"
             (propertize (mapconcat 'identity
                                    (ublt/flymake-err-at (point)) "\n")
                         'face 'ublt/flymake-message-face)))

(defadvice flymake-goto-next-error (after display-message activate)
  (ublt/flymake-err-echo))
(defadvice flymake-goto-prev-error (after display-message activate)
  (ublt/flymake-err-echo))

(eval-after-load "js"
  '(ublt/set-up 'flymake-jshint
     (setq jshint-configuration-path "~/.jshint.json")
     (defun ublt/flymake-js-enable ()
       (when (and buffer-file-name
                  (string-match "\\.js$" buffer-file-name))
         (flymake-mode +1)))
     (remove-hook 'js-mode-hook 'flymake-mode)
     (add-hook 'js-mode-hook 'ublt/flymake-js-enable)))

(eval-after-load "php-mode"
  '(ublt/set-up 'flymake-php
     (add-hook 'php-mode-hook 'flymake-php-load)))

(defun enable-flymake () (flymake-mode 1))
(dolist (hook '(emacs-lisp-mode-hook))
  (add-hook hook #'enable-flymake))


(provide 'ublt-flymake)
