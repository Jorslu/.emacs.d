(require 'ublt-util)

(eval-when-compile
  (require 'cl))

(require 'dired+)

(ublt/in '(darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program t)
  (setq insert-directory-program "/opt/local/libexec/gnubin/ls"))

;;; Apparently this works much better than dired-do-async-shell-command and
;; nohup trickeries
(defun ublt/dired-open-native ()
  "Open marked files (or the file the cursor is on) from dired."
  (interactive)
  (let* ((files (dired-get-marked-files t current-prefix-arg))
         (n (length files)))
    (when (or (<= n 3)
              (y-or-n-p (format "Open %d files?" n)))
      (dolist (file files)
        (call-process (case system-type
                        ('darwin "open")
                        ('gnu/linux "xdg-open"))
                      nil 0 nil file)))))

;;; TODO: Improve & use
(defun ublt/dired-rsync (dest)
  (interactive
   (list (expand-file-name (read-file-name "Rsync to:"))))

  (let ((files (dired-get-marked-files nil current-prefix-arg)))
    (dolist (file files)
      (message "%s => %s" file dest)
      (start-process "rsync" "*rsync*" "rsync"
                     "-rvz" file dest))))

;; Highlight current line
(add-hook 'dired-mode-hook (ublt/on-fn 'hl-line-mode))

(ublt/set-up 'dired-x
  (setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^\\.")
  (setq-default dired-omit-mode t))

(ublt/set-up 'dired-aux
  (setq dired-isearch-filenames 'dwim))

;; Directories first by default. "s d" to change locally
(ublt/set-up 'dired-sort-map
  (setq dired-listing-switches "--group-directories-first -alhG1v"))

(setq
 ;; Offer the other window's path as default when copying
 dired-dwim-target t

 ;; Make find-name-dired ignore case
 find-name-arg "-iname"

 dired-hide-details-hide-symlink-targets nil
 ;;
 dired-guess-shell-alist-user
 (list
  (list "\\.t\\(ar\\.bz2\\|bz\\)\\'"
        "tar xvjf"
        "bunzip2 -c * | tar xvf -"
        ;; Extract files into a separate subdirectory
        '(concat "mkdir " (file-name-sans-extension file)
                 "; bunzip2 -c * | tar -C "
                 (file-name-sans-extension file) " -xvf -")
        ;; Optional decompression.
        "bunzip2"))
 )

(provide 'ublt-dired)
