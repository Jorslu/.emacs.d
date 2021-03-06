(unless (>= emacs-major-version 24)
  (error "Ublt dark theme requires Emacs 24 or later"))

(defface ublt/default-variable-width
  '((t (:inherit variable-pitch)))
  "")

(defvar ublt/text-scale-fw-remapping nil)
(make-variable-buffer-local 'ublt/text-scale-fw-remapping)

(defvar ublt/text-scale-vw-remapping nil)
(make-variable-buffer-local 'ublt/text-scale-vw-remapping)

(defadvice text-scale-mode (after scale-base-faces activate)
  "Additionally scale other base faces so that all faces are
scaled. This \"base face\" trick is used by `ublt-themes'."
  (let ((ratio (car (last text-scale-mode-remapping))))
    (when ublt/text-scale-fw-remapping
      (face-remap-remove-relative ublt/text-scale-fw-remapping))
    (when ublt/text-scale-vw-remapping
      (face-remap-remove-relative ublt/text-scale-vw-remapping))
    (when ratio
      (setq ublt/text-scale-vw-remapping
            (face-remap-add-relative 'ublt/default-variable-width
                                     :height ratio))
      (setq ublt/text-scale-fw-remapping
            (face-remap-add-relative 'fixed-pitch
                                     :height ratio))
      )
    (force-window-update (current-buffer))))

(deftheme ublt-dark "Ubolonton's dark color theme")

(let* ((class     '((class color) (min-colors 257)))

       (radio     "#9ACD32")
       (yellow    "#FFFF00")
       (orange    "#FF8C00")
       (golden    "#B8860B")
       (blush     "#F86155")
       (skin      "#D98D54")
       (magenta   "#805DBB")
       (magenta-d "#6A5ACD")
       ;; (violet "")
       (blue-l    "#7991E3")
       (blue      "#0084CF")
       (blue-d    "#223360")
       (cyan      "#00CDCD")
       ;; (sky       "LightSkyBlue")
       (spring    "#00FA9A")
       (aqua      "#66CDAA")
       (grass     "#00DD00")
       (forest    "#228B22")
       (seaweed   "#2E8B57")


       ;; ;; These should probably be used more

       ;; ;; Preprocessor, write priv
       ;; "#D98D54"
       ;; ;; dired header, ido first match, org time grid
       ;; "#EEDD82"
       ;; ;; helm match, helm mode-line bg, failed isearch, something in magit
       ;; "#9ACD32"
       ;; ;; type (f)
       ;; "#00FA9A"
       ;; ;; highlight (b)
       ;; "#223360"


       ;; ;; Used very little, consider using other colors, or something:

       ;; ;; Diff (b)
       ;; "#CD1111"
       ;; ;; Mode-line texts (f)
       ;; "#8B0000"
       ;; ;; Error highlighting (b)
       ;; "#8B1A1A"
       ;; ;; Regex grouping (f)
       ;; "#FF4500"
       ;; ;; org table, org done, org scheduled today (f)
       ;; "#90EE90"
       ;; ;; org date, prompt, link (f)
       ;; "#00CDCD"
       ;; ;; whitespace highlighting (f)
       ;; "#66CDAA"
       ;; ;; mode-line, link (f) (b)
       ;; "#7991E3"
       ;; ;; References? (f)
       ;; "#6A5ACD"
       ;; ;; org-agenda-structure
       ;; "LightSkyBlue"
       ;; ;; org-scheduled-previously
       ;; "#FF7F24"

       (bg   "#0C1320")
       (bg+1 "#131A27")
       (bg+2 "#1F2633")
       (bg+3 "#2C3340")
       (fg-3 "#505764")
       (fg-2 "#626976")
       (fg-1 "#747B88")
       (fg   "#858C99")
       (fg+1 "#B8C1C9")

       (warning      `(:foreground "#FF0000"))
       (error-hl     `(:background "#8B1A1A"))
       (power        `(:foreground ,blush))
       (commitment   `(:foreground ,blush))
       (raw          `(:foreground "#D98D54"))

       (minus        `(:foreground "#CD1111"))
       (plus         `(:foreground ,forest))
       (context      `(:foreground ,fg-3))
       (dimmed       `(:foreground ,bg+3))
       (shadowed     `(:foreground ,bg+2))
       (spectral     `(:foreground ,bg+1))
       (invisible    `(:foreground ,bg))

       (param        `(:foreground ,orange))
       (mutable      `(:foreground ,golden))
       (exception-hl `(:background ,radio))

       (header        `(:foreground "#EEDD82"))
       (subheader     `(:foreground ,golden))

       (essence      `(:foreground ,grass))
       (more         `(:foreground ,grass))

       (string       `(:foreground ,forest))
       (doc          `(:foreground ,seaweed))

       (type         `(:foreground ,spring))
       (portal       `(:foreground ,blue-l))
       (teleport     `(:foreground ,cyan))
       (prompt       `(:foreground ,cyan))

       (constant     `(:foreground ,blue))

       (number       `(:foreground ,seaweed))

       (reference    `(:foreground ,magenta-d))

       (spectral-hl  `(:background "#0F1724"))
       (dimmed-hl    `(:background ,bg+1))
       (normal-hl    `(:background ,bg+2))
       (strong-hl    `(:background ,bg+3))
       (special-hl   `(:background ,blue-d))

       (strong       `(:foreground ,fg+1))

       (note         `(:foreground ,magenta)) ; meta?

       (status       `(:background ,blue-l))

       ;; Mixins

       ;; Fixed-width (unscalable)
       (fw0           `(:font ,(face-attribute 'fixed-pitch :font)
                              :weight light
                              :fontset ,(face-attribute 'fixed-pitch :fontset)))
       ;; Variable-width (unscalable)
       (vw0           `(:font ,(face-attribute 'variable-pitch :font)
                              :fontset ,(face-attribute 'variable-pitch :fontset)))
       ;; Fixed-width (scalable)
       (fw             '(:inherit fixed-pitch))
       ;; Variable-width (scalable)
       (vw             '(:inherit ublt/default-variable-width))
       (vw-italic      `(,@vw :weight light :slant italic))

       (bold           `(:weight bold))

       )
  (custom-theme-set-faces
   'ublt-dark


   ;; Mixin bases. Most faces that wish to always use
   ;; fixed-width/variable-width font should inherit these, not
   ;; `default', which gets font remapped. `text-scale-mode' is
   ;; advised to scale them correctly.
   `(fixed-pitch
     ((,class (,@fw0))))
   `(ublt/default-variable-width
     ((,class (,@vw0))))

   ;; Bases
   `(default
      ((,class (,@fw0 :foreground ,fg :background ,bg))))
   `(variable-pitch
     ((,class (,@vw0 :foreground ,fg-1))))

   `(shadow ((,class (,@dimmed))))
   `(link ((,class (,@portal :underline ,bg+3))))
   `(button
     ((,class (,@fw ,@portal :underline ,bg+3))))

   ;; mode-line
   `(mode-line
     ((,class (,@fw ,@status :foreground ,bg+1))))
   `(mode-line-inactive
     ((,class (:inherit mode-line ,@normal-hl ,@strong :foreground ,fg-1))))
   `(mode-line-buffer-id
     ((,class (,@vw :weight bold :height 0.9))))
   `(mode-line-highlight
     ((,class (:inherit mode-line))))
   ;; `(which-func                          ;TODO
   ;;   ((,class (:foreground ,red-2 :height 1.0 :bold t))))
   `(anzu-mode-line                     ;TODO
     ((,class (:foreground ,blue-d :weight bold))))

   ;; Fringe
   `(fringe
     ((,class (,@context ,@fw0))))
   `(vertical-border
     ((,class (,@shadowed))))
   ;; Line number
   `(linum
     ((,class (:inherit fringe ,@dimmed :slant normal :weight normal
                        :underline nil :strike-through nil :overline nil
                        :background ,bg :box nil))))
   `(linum-relative-current-face
     ((,class (:inherit (hl-line linum) ,@context ,@bold))))


   ;; Highlighting, flyspell, flycheck

   `(hl-line                            ;TODO: Less dimmed
     ((,class (,@dimmed-hl))))
   `(region
     ((,class (,@normal-hl))))
   `(eval-sexp-fu-flash                 ;Flashing eval'ed expression
     ((,class (,@normal-hl))))
   `(eval-sexp-fu-flash-error
     ((,class (,@warning))))
   `(secondary-selection                ;Highlight changes
     ((,class (,@special-hl))))
   `(highlight                          ;TODO: What is this?
     ((,class (,@normal-hl))))
   `(match
     ((,class (,@strong-hl))))
   ;; Search
   `(isearch                            ;current match
     ((,class (,@special-hl :foreground ,yellow))))
   `(lazy-highlight                     ;other matches
     ((,class (,@special-hl))))
   `(isearch-fail                       ;no match
     ((,class (,@error-hl))))
   ;; Parens
   `(show-paren-match                   ;matching
     ((,class (,@strong))))
   `(show-paren-mismatch                ;unmatched
     ((,class (:inherit font-lock-warning-face))))
   `(ublt/lisp-paren-face               ;dimmed
     ((,class (,@dimmed))))

   ;; flyspell
   `(flyspell-incorrect
     ((,class (:underline (:color ,blush :style wave)))))
   `(flyspell-duplicate
     ((,class (:underline (:color ,radio :style wave)))))
   ;; flycheck
   `(flycheck-error
     ((,class (,@error-hl))))


   ;; diffs & git

   `(diff-added
     ((,class (,@plus))))
   `(diff-removed
     ((,class (,@minus))))
   `(diff-refine-added
     ((,class (:inherit diff-added ,@normal-hl))))
   `(diff-refine-removed
     ((,class (:inherit diff-removed ,@normal-hl))))
   `(diff-context
     ((,class ,context)))
   `(diff-indicator-added
     ((,class (:inherit diff-added))))
   `(diff-indicator-removed
     ((,class (:inherit diff-removed))))
   `(diff-header
     ((,class (:inherit header-line))))
   `(diff-file-header                   ;TODO
     ((,class (:foreground ,spring))))
   `(diff-hunk-header                   ;TODO
     ((,class (,@constant :slant italic))))

   `(ediff-even-diff-A
     ((,class (,@normal-hl))))
   `(ediff-even-diff-B
     ((,class (,@strong-hl))))
   `(ediff-even-diff-C
     ((,class (,@strong-hl))))
   `(ediff-even-diff-Ancestor
     ((,class (,@strong-hl))))
   `(ediff-odd-diff-A
     ((,class (:inherit ediff-even-diff-B))))
   `(ediff-odd-diff-B
     ((,class (:inherit ediff-even-diff-A))))
   `(ediff-odd-diff-C
     ((,class (:inherit ediff-even-diff-Ancestor))))
   `(ediff-odd-diff-Ancestor
     ((,class (:inherit ediff-even-diff-C))))

   ;; HSV (V)
   ;; orig: 17 20 20 31
   ;; low: 13 15 15 25
   ;; hi: 21 22 25 36
   `(ediff-current-diff-A
     ((,class (:background "#210E18"))))
   `(ediff-current-diff-B
     ((,class (:background "#092618"))))
   `(ediff-current-diff-C
     ((,class (:background "#212618"))))
   `(ediff-current-diff-Ancestor
     ((,class (:background "#090F3D"))))
   `(ediff-fine-diff-A
     ((,class (:background "#361727"))))
   `(ediff-fine-diff-B
     ((,class (:background "#0D3823"))))
   `(ediff-fine-diff-C
     ((,class (:background "#374028"))))
   `(ediff-fine-diff-Ancestor
     ((,class (:background "#0E165C"))))

   `(magit-item-highlight
     ((,class (,@dimmed-hl))))
   `(magit-section-title
     ((,class (,@vw ,@mutable :weight bold))))
   `(magit-branch
     ((,class (,@more))))
   `(magit-diff-file-header
     ((,class (:inherit diff-file-header))))
   `(magit-diff-hunk-header
     ((,class (:inherit diff-hunk-header))))
   `(magit-diff-add
     ((,class (:inherit diff-added))))
   `(magit-diff-del
     ((,class (:inherit diff-removed))))
   `(magit-diff-none
     ((,class (:inherit diff-context))))
   `(magit-log-head-label-default
     ((,class (:inherit magit-log-head-label-remote ,@mutable))))
   `(magit-log-sha1
     ((,class (,@fw ,@commitment))))
   `(magit-item-mark
     ((,class (:inherit secondary-selection))))
   `(magit-tag                          ;TODO
     ((,class (:foreground ,seaweed :box ,bg+3))))
   `(magit-log-head-label-tags
     ((,class (:inherit magit-tag))))
   `(magit-log-author
     ((,class (,@vw ,@context))))
   `(magit-log-date
     ((,class (,@vw ,@dimmed))))
   `(magit-log-message
     ((,class (,@vw-italic))))
   `(magit-key-mode-switch-face
     ((,class (:inherit font-lock-type-face))))
   `(magit-blame-header
     ((,class (,@vw ,@normal-hl :foreground ,fg-1))))
   ;; TODO
   ;; (magit-blame-sha1
   ;;  ((t ())))
   `(magit-blame-culprit
     ((,class (:inherit magit-blame-header))))
   `(magit-blame-time
     ((,class (:inherit magit-blame-header ,@context))))
   `(magit-blame-subject
     ((,class (:inherit (magit-log-message magit-blame-header)))))

   `(magit-section-highlight
     ((,class (,@normal-hl))))
   `(magit-section-heading
     ((,class (,@vw ,@mutable :weight bold))))
   `(magit-branch-local
     ((,class (,@more))))
   `(magit-branch-current
     ((,class (,@more :box (:color ,fg-2)))))
   `(magit-branch-remote
     ((,class (,@doc))))
   `(magit-diff-file-heading
     ((,class (:inherit magit-file-name :weight normal))))
   `(magit-diff-file-heading-highlight
     ((,class (:inherit magit-diff-file-heading ,@normal-hl :weight bold))))
   `(magit-diff-hunk-heading
     ((,class (:inherit diff-hunk-header :overline ,bg+3))))
   `(magit-diff-hunk-heading-highlight
     ((,class (:inherit magit-diff-hunk-heading ,@special-hl :overline ,fg :weight bold))))
   `(magit-diff-added
     ((,class (:inherit diff-added))))
   `(magit-diff-removed
     ((,class (:inherit diff-removed))))
   `(magit-diff-context
     ((,class (:inherit diff-context))))
   `(magit-diff-added-highlight
     ((,class (:inherit magit-diff-added ,@dimmed-hl))))
   `(magit-diff-removed-highlight
     ((,class (:inherit magit-diff-removed ,@dimmed-hl))))
   `(magit-diff-context-highlight
     ((,class (:inherit maigt-diff-context ,@dimmed-hl))))
   ;; `(magit-log-head-label-default
   ;;   ((,class (:inherit magit-log-head-label-remote ,@mutable))))
   `(magit-hash
     ((,class (,@fw ,@commitment))))
   ;; `(magit-item-mark
   ;;   ((,class (:inherit secondary-selection))))
   ;; `(magit-tag                          ;TODO
   ;;   ((,class (:foreground ,seaweed :box ,bg+3))))
   ;; `(magit-log-head-label-tags
   ;;   ((,class (:inherit magit-tag))))
   ;; `(magit-log-author
   ;;   ((,class (,@vw ,@context))))
   ;; `(magit-log-date
   ;;   ((,class (,@vw ,@dimmed))))
   ;; `(magit-log-message
   ;;   ((,class (,@vw-italic))))
   ;; `(magit-key-mode-switch-face
   ;;   ((,class (:inherit font-lock-type-face))))
   `(magit-blame-heading
     ((,class (,@vw ,@normal-hl :foreground ,fg-1 :overline ,bg+3))))
   `(magit-blame-hash
     ((,class (:inherit magit-hash))))
   `(magit-blame-name
     ((,class (:inherit magit-blame-heading))))
   `(magit-blame-date
     ((,class (:inherit magit-blame-heading ,@context))))
   `(magit-blame-summary
     ((,class (:inherit (git-commit-summary magit-blame-heading)))))
   `(magit-popup-argument
     ((,class (:inherit font-lock-variable-name-face))))

   `(git-commit-summary-face
     ((,class (:inherit magit-log-message))))
   `(git-commit-overlong-summary-face
     ((,class (:inherit git-commit-summary-face :foreground ,blush))))
   `(git-commit-nonempty-second-line-face
     ((,class (:inherit git-commit-summary-face ,@error-hl))))
   `(git-commit-comment-heading-face
     ((,class (:inherit magit-section-title :weight normal))))
   `(git-commit-comment-action-face
     ((,class (,@fw ,@commitment))))
   `(git-commit-comment-file-face
     ((,class (,@vw ,@string))))
   `(git-commit-branch-face
     ((,class (,@fw ,@more :box ,bg+3))))

   `(git-commit-summary
     ((,class (:inherit magit-log-message))))
   `(git-commit-overlong-summary
     ((,class (:inherit git-commit-summary-face :foreground ,blush))))
   `(git-commit-nonempty-second-line
     ((,class (:inherit git-commit-summary-face ,@error-hl))))
   `(git-commit-comment-heading
     ((,class (:inherit magit-section-heading :weight normal))))
   `(git-commit-comment-action
     ((,class (,@fw ,@commitment))))
   `(git-commit-comment-file
     ((,class (,@vw ,@string))))
   `(git-commit-comment-branch
     ((,class (,@fw ,@more :box ,bg+3))))

   `(diff-hl-insert
     ((,class (:foreground ,bg :background ,forest))))
   `(diff-hl-delete
     ((,class (:foreground ,blush :background ,blush))))
   `(diff-hl-change
     ((,class (:foreground ,cyan :background ,cyan))))


   ;; Programming languages

   `(font-lock-builtin-face
     ((,class (,@fw ,@constant))))
   `(font-lock-comment-face
     ((,class (,@vw-italic ,@note))))
   `(font-lock-comment-delimiter-face
     ((,class (:inherit font-lock-comment-face ,@shadowed))))
   `(font-lock-doc-string-face
     ((,class (,@fw ,@doc))))
   `(font-lock-function-name-face
     ((,class (,@fw ,@essence))))
   `(font-lock-keyword-face
     ((,class (,@fw ,@power))))
   `(font-lock-reference-face
     ((,class (,@fw ,@reference))))     ; TODO What's this?
   `(font-lock-regexp-grouping-backslash
     ((,class (,@fw ,@spectral))))
   `(font-lock-regexp-grouping-construct
     ((,class (,@fw ,@constant))))
   `(font-lock-string-face
     ((,class (,@fw ,@string))))
   `(font-lock-doc-face
     ((,class (,@vw-italic ,@string))))
   `(font-lock-type-face
     ((,class (,@fw ,@type))))
   `(font-lock-preprocessor-face
     ((,class (,@fw ,@raw))))
   `(font-lock-variable-name-face
     ((,class (,@fw ,@mutable))))
   `(font-lock-warning-face
     ((,class (,@fw ,@warning))))
   `(font-lock-constant-face
     ((,class (,@fw ,@constant))))
   `(number-font-lock-face
     ((,class (,@fw ,@number))))

   `(js2-function-param
     ((,class (,@param))))
   `(js2-jsdoc-type
     ((,class (:inherit font-lock-type-face))))
   `(js2-jsdoc-tag
     ((,class (:inherit font-lock-builtin-face))))

   `(js3-function-param
     ((,class (,@param))))
   `(js3-jsdoc-type
     ((,class (:inherit font-lock-type-face))))
   `(js3-jsdoc-tag
     ((,class (:inherit font-lock-builtin-face))))

   `(web-mode-preprocessor-face
     ((,class (,@context))))
   `(web-mode-html-attr-name-face
     ((,class (:inherit font-lock-variable-name-face))))
   `(web-mode-param-name-face
     ((,class (:inherit font-lock-constant-face))))
   `(web-mode-html-attr-equal-face
     ((,class (,@context))))
   `(web-mode-html-tag-face
     ((,class (:inherit font-lock-builtin-face))))
   `(web-mode-html-tag-custom-face
     ((,class (:inherit web-mode-html-tag-face :slant italic :underline ,bg+3))))
   `(web-mode-part-face
     ((,class (,@dimmed-hl))))
   `(web-mode-block-face
     ((,class (,@dimmed-hl))))
   `(web-mode-block-delimiter-face
     ((,class (:inherit web-mode-block-face ,@dimmed))))
   `(web-mode-css-selector-face
     ((,class (:inherit font-lock-function-name-face))))
   `(web-mode-current-element-highlight-face
     ((,class (:inherit highlight))))
   `(web-mode-comment-keyword-face
     ((,class (:inherit font-lock-warning-face))))
   `(web-mode-html-tag-bracket-face
     ((,class (,@fw ,@context))))
   `(web-mode-folded-face
     ((,class (:underline t))))

   `(nxml-element-prefix
     ((,class (,@fw ,@context))))
   `(nxml-element-local-name
     ((,class (:inherit font-lock-builtin-face))))
   `(nxml-tag-delimiter
     ((,class (,@fw ,@dimmed))))
   `(nxml-processing-instruction-delimiter
     ((,class (:inherit nxml-tag-delimiter))))
   `(nxml-markup-declaration-delimiter
     ((,class (:inherit nxml-tag-delimiter))))
   `(nxml-entity-ref-name
     ((,class (,@fw :foreground ,skin))))

   `(sh-heredoc
     ((,class (,@doc ,@bold))))


   ;; Non-HTML markup languages

   ;; org-mode
   ;; TODO: levels
   `(org-document-title
     ((,class (,@string :height 2.0 :bold t))))
   `(org-special-keyword
     ((,class (,@fw ,@constant))))
   `(org-indent                         ;TODO
     ((,class (:inherit org-hide ;; :foreground ,bg+2 :background ,bg+2
                        ))))
   ;; We use `normal' not `bold' for these because we use Fira Sans
   `(org-level-1
     ((,class (,@vw ,@constant :weight normal :overline ,bg+2 :height 1.4 ,@spectral-hl))))
   `(org-level-2
     ((,class (,@vw ,@mutable :weight normal :overline ,bg+2 :height 1.2 ,@spectral-hl))))
   `(org-level-3
     ((,class (,@string :weight normal :height 1.1))))
   `(org-level-4
     ((,class (:foreground ,cyan :weight normal :height 1.0))))
   `(org-level-5
     ((,class (,@param))))
   `(org-level-6
     ((,class (:foreground ,radio))))
   ;; `(org-level-7                        ;TODO
   ;;  ((,class (:foreground ,green-3))))
   `(org-level-8
     ((,class (,@note))))
   `(org-table                          ;TODO
     ((,class (,@fw :overline ,bg+1 :foreground ,blue-l))))
   `(org-formula
     ((,class (,@fw ,@param))))
   `(org-hide
     ((,class (:foreground ,bg))))
   `(org-code
     ((,class (:inherit font-lock-builtin-face))))
   `(org-verbatim
     ((,class (:inherit font-lock-keyword-face))))
   `(org-meta-line
     ((,class (,@fw ,@context))))
   `(org-document-info-keyword
     ((,class (:inherit org-meta-line))))
   ;; `(org-mode-line-clock                ;TODO
   ;;  ((,class (:foreground ,blush-2 :bold t))))
   `(org-link
     ((,class (:inherit link))))
   `(org-date                           ;TODO
     ((,class (,@fw :foreground ,cyan :underline t))))
   `(org-todo
     ((,class (,@commitment))))
   ;; `(org-done                           ;TODO
   ;;  ((,class (:foreground ,green-3))))
   ;; FIX: This makes comment in code block fixed-width :(
   `(org-block
     ((,class (,@fw))))
   `(org-block-background
     ((,class (,@fw ,@spectral-hl))))
   `(org-block-begin-line
     ((,class (:inherit org-block-background ,@constant :underline ,blue-d))))
   `(org-block-end-line
     ((,class (:inherit org-block-background ,@spectral :overline ,blue-d))))
   `(org-checkbox
     ((,class (,@fw :weight bold :box (:line-width 1 :style released-button :color ,bg)))))
   `(org-time-grid
     ((,class (,@fw ,@context))))
   ;; `(org-agenda-structure               ;TODO
   ;;  ((,class (,@fw :foreground "LightSkyBlue"))))
   `(org-agenda-date-today
     ((,class (:inherit org-agenda-date :underline t))))
   `(org-agenda-date-weekend
     ((,class (:inherit org-agenda-date :slant italic))))
   `(org-agenda-current-time
     ((,class (,@fw :inherit org-time-grid ,@header :background ,bg+2))))
   `(org-scheduled-previously
     ((,class (,@fw :foreground ,blue-l))))
   `(org-scheduled-today
     ((,class (,@fw :foreground ,radio))))
   `(org-agenda-done
     ((,class (,@fw :foreground ,seaweed))))
   `(org-tag
     ((,class (,@fw ,@context))))
   ;; `(org-scheduled                      ;TODO
   ;;  ((,class (,@vw-italic :foreground ,green-2))))
   ;; `(org-scheduled-previously           ;TODO
   ;;  ((,class (,@fw :foreground "Chocolate1" :slant italic))))
   ;; `(org-scheduled-today                ;TODO
   ;;  ((,class (,@vw :foreground ,green-3))))
   `(org-column
     ((,class (,@fw :slant normal))))
   `(org-priority
     ((,class (:foreground ,radio))))
   `(org-headline-done
     ((,class (:inherit org-level-2 ,@context))))

   `(markdown-link-face
     ((,class (,@teleport))))
   `(markdown-url-face
     ((,class (:inherit org-link))))
   `(markdown-header-delimiter-face
     ((,class (,@dimmed))))
   `(markdown-header-face-1
     ((,class (:inherit org-level-1))))
   `(markdown-header-face-2
     ((,class (:inherit org-level-2))))
   `(markdown-header-face-3
     ((,class (:inherit org-level-3))))
   `(markdown-header-face-4
     ((,class (:inherit org-level-4))))
   `(markdown-header-face-5
     ((,class (:inherit org-level-5))))
   `(markdown-header-face-6
     ((,class (:inherit org-level-6))))
   `(markdown-list-face
     ((,class (,@mutable :weight bold))))
   `(markdown-pre-face             ;TODO: Make it similar to org-block
     ((,class (,@fw ,@dimmed-hl ,@string))))
   `(markdown-bold-face
     ((,class (,@mutable :weight bold))))
   `(markdown-italic-face
     ((,class (,@mutable :slant italic))))

   `(rst-level-1
     ((,class (:inherit org-level-1))))
   `(rst-level-2
     ((,class (:inherit org-level-2))))
   `(rst-level-3
     ((,class (:inherit org-level-3))))
   `(rst-adornment
     ((,class (,@context))))
   `(rst-block
     ((,class (:inherit markdown-list-face))))
   `(rst-literal
     ((,class (:inherit org-code))))
   `(rst-reference                      ;TODO
     ((,class (:inherit org-code))))
   `(rst-definition                     ;TODO
     ((,class (:inherit org-link))))
   `(rst-emphasis1
     ((,class (:inherit markdown-italic-face))))
   `(rst-emphasis2
     ((,class (:inherit markdown-bold-face))))

   `(markup-title-0-face
     ((,class (:inherit org-document-title))))
   `(markup-title-1-face
     ((,class (:inherit org-level-1))))
   `(markup-title-2-face
     ((,class (:inherit org-level-2))))
   `(markup-title-3-face
     ((,class (:inherit org-level-3))))
   `(markup-title-4-face
     ((,class (:inherit org-level-4))))
   `(markup-title-5-face
     ((,class (:inherit org-level-5))))
   `(markup-internal-reference-face
     ((,class (:inherit org-link))))
   `(markup-typewriter-face
     ((,class (:inherit org-code))))
   `(markup-code-face
     ((,class (:inherit markdown-pre-face))))
   `(markup-list-face
     ((,class (:inherit markdown-list-face))))


   ;; helm

   `(helm-header
     ((,class (,@vw ,@header))))        ; TODO
   `(helm-source-header
     ((,class (,@vw ,@dimmed-hl ,@subheader ,@bold)))) ; TODO
   ;; XXX: Maybe I just don't believe in themes with narrow
   ;; selection of colors
   `(helm-selection
     ((,class (:inherit secondary-selection))))
   `(helm-selection-line
     ((,class (:inherit secondary-selection))))
   `(helm-match
     ((,class (:foreground ,radio ,@bold))))
   `(helm-grep-match
     ((,class (:foreground ,yellow))))
   `(helm-ff-file
     ((,class (,@portal))))
   `(helm-ff-directory
     ((,class (:inherit diredp-dir-priv ,@fw ,dimmed-hl))))
   `(helm-ff-symlink
     ((,class (:inherit diredp-symlink))))
   `(helm-ff-executable
     ((,class (:inherit diredp-exec-priv))))
   ;; `(helm-candidate-number
   ;;   ((,class (:background ,yellow-1 :foreground ,bg :bold t)))) ; TODO
   `(helm-separator
     ((,class (,@shadowed))))
   `(helm-grep-file
     ((,class (,@reference))))
   `(helm-moccur-buffer                 ;TODO
     ((,class (,@reference))))
   `(helm-grep-lineno
     ((,class (,@number))))
   ;; `(helm-grep-finish                   ;TODO
   ;;   ((,class (,@doc))))
   `(helm-action
     ((,class (,@vw :height 1.1))))
   `(helm-buffer-directory
     ((,class (:inherit helm-ff-directory))))
   ;; helm-swoop
   `(helm-swoop-target-line-face
     ((,class (:inherit secondary-selection))))
   `(helm-swoop-target-line-block-face
     ((,class (:inherit secondary-selection))))
   `(helm-swoop-line-number-face
     ((,class (,@number))))
   `(helm-swoop-target-word-face
     ((,class (,@normal-hl))))


   ;; dired

   `(diredp-file-name                   ;TODO
     ((,class (,@vw))))
   `(diredp-dir-priv
     ((,class (,@vw ,@more))))
   `(diredp-dir-heading                 ;TODO
     ((,class (,@header))))
   `(dired-symlink
     ((,class (,@teleport))))
   `(diredp-symlink
     ((,class (,@teleport))))
   `(diredp-no-priv
     ((,class (,@dimmed-hl ,@spectral))))
   `(diredp-read-priv
     ((,class (:inherit diredp-no-priv ,@more))))
   `(diredp-write-priv
     ((,class (:inherit diredp-no-priv ,@power))))
   `(diredp-exec-priv
     ((,class (:inherit diredp-no-priv ,@raw))))
   `(diredp-number
     ((,class (,@number))))
   `(diredp-flag-mark-line              ;selected
     ((,class (,@special-hl ,@vw))))
   `(diredp-deletion                    ;marked for deletion
     ((,class (,@error-hl ,@vw))))
   `(diredp-deletion-file-name
     ((,class (,@error-hl))))
   `(diredp-compressed-file-suffix      ;TODO
     ((,class (,@constant))))
   `(diredp-file-suffix
     ((,class (,@context))))
   `(diredp-ignored-file-name
     ((,class (,@vw-italic ,@note))))
   ;; `(diredp-mode-line-marked
   ;;   ((,class (:bold t :foreground ,blue))))
   ;; `(diredp-mode-line-flagged
   ;;   ((,class (:bold t :foreground ,blush-2))))


   ;; REPLs

   `(comint-highlight-prompt
     ((,class (,@prompt))))
   `(comint-highlight-input
     ((,class (:background ,bg+1 :foreground ,fg-1))))

   `(cider-repl-prompt-face
     ((,class (:inherit font-lock-constant-face))))
   `(cider-repl-input-face
     ((,class (:inherit comint-highlight-input))))
   `(cider-repl-result-face
     ((,class (,@constant))))           ; TODO

   `(eshell-prompt
     ((,class (,@prompt))))


   ;; Help

   ;; info
   `(info-title-1
     ((,class (:inherit org-level-1 :weight bold))))
   `(info-title-2
     ((,class (:inherit org-level-2 :weight bold))))
   `(info-title-3
     ((,class (:inherit org-level-3 :weight bold))))
   `(info-title-4
     ((,class (:inherit org-level-4 :weight bold))))
   `(info-menu-header
     ((,class (:weight bold))))
   `(info-xref
     ((,class (,@portal :slant italic))))
   `(info-xref-visited
     ((,class (:inherit info-xref ,@note :weight bold :slant normal))))
   `(info-quoted-name
     ((,class (,@fw ,@constant))))
   `(info-single-quote
     ((,class (,@constant))))
   `(info-string
     ((,class (:foreground ,radio))))
   `(info-reference-item
     ((,class (,@fw ,@mutable :weight bold :height 1.1))))
   `(info-function-ref-item
     ((,class (:weight bold :slant italic :height 0.7))))
   `(info-constant-ref-item
     ((,class (,@constant :inherit info-function-ref-item))))
   `(info-user-option-ref-item
     ((,class (,@param :inherit info-function-ref-item :slant normal))))
   `(info-variable-ref-item
     ((,class (,@mutable :inherit info-function-ref-item))))
   `(info-macro-ref-item
     ((,class (,@power :inherit info-function-ref-item))))
   `(info-special-form-ref-item
     ((,class (,@power :inherit info-function-ref-item :slant normal))))
   `(info-command-ref-item
     ((,class (,@type :inherit info-function-ref-item))))

   ;; apropos
   `(apropos-symbol
     ((,class (:inherit info-reference-item))))
   `(apropos-function-button
     ((,class (:inherit info-function-ref-item))))
   `(apropos-variable-button
     ((,class (:inherit info-variable-ref-item))))
   `(apropos-misc-button
     ((,class (:inherit info-constant-ref-item))))

   `(help-argument-name                 ;TODO
     ((,class (,@fw :foreground ,blue))))
   `(describe-variable-value
     ((,class (,@fw ,@doc))))

   ;; man/woman
   `(woman-bold                         ;TODO
     ((,class (,@constant))))
   `(woman-italic
     ((,class (:foreground ,spring))))
   `(woman-addition                     ;TODO
     ((,class (,@mutable))))
   `(woman-unknown                      ;TODO
     ((,class (:foreground ,blush))))
   `(Man-overstrike
     ((,class (:inherit woman-bold))))
   `(Man-underline
     ((,class (:inherit woman-italic))))

   
   ;; IRC

   `(erc-notice-face
     ((,class (,@dimmed))))
   `(erc-nick-default-face              ;TODO
     ((,class (,@string))))
   `(erc-current-nick-face
     ((,class (,@constant))))
   `(erc-my-nick-face
     ((,class (,@constant))))
   `(erc-timestamp-face
     ((,class (,@note))))
   `(erc-prompt-face
     ((,class (,@prompt :bold t))))
   `(erc-command-indicator-face
     ((,class (:slant italic :weight normal))))
   `(erc-button
     ((,class (:slant normal))))

   
   ;; Popups

   `(company-tooltip
     ((,class (,@fw ,@strong-hl :foreground ,aqua))))
   `(company-tooltip-selection
     ((,class (:inherit company-tooltip :foreground ,cyan :background ,fg-3))))
   `(company-tooltip-common
     ((,class (:inherit company-tooltip ,@mutable))))
   `(company-tooltip-common-selection
     ((,class (:inherit company-tooltip-selection ,@param))))
   `(company-tooltip-annotation
     ((,class (:inherit company-tooltip :foreground ,seaweed))))
   `(company-scrollbar-bg
     ((,class (:background ,fg-3))))
   `(company-scrollbar-fg
     ((,class (:background ,seaweed))))
   `(company-preview
     ((,class (:foreground ,fg-3))))
   `(company-preview-common
     ((,class (:inherit company-preview))))


   ;; Misc

   ;; undo-tree
   `(undo-tree-visualizer-default-face
     ((,class (,@dimmed))))
   `(undo-tree-visualizer-current-face
     ((,class (,@essence))))
   `(undo-tree-visualizer-active-branch-face ;TODO
     ((,class (,@string))))

   `(compilation-info
     ((,class (,@reference))))
   `(compilation-error
     ((,class (,@warning))))
   `(compilation-line-number            ;TODO
     ((,class (,@number))))

   ;; XXX: Why aren't these even registered?
   `(hexl-address-region
     ((,class (:foreground ,blue))))
   `(hexl-ascii-region
     ((,class (:foreground ,blue))))

   ;; yasnippet
   `(yas--field-debug-face
     ((,class (:underline ,yellow))))
   `(yas-field-highlight-face
     ((,class (,@strong-hl))))

   ;; ace-jump
   `(ace-jump-face-foreground
     ((,class (:underline nil :box nil
                          :strike-through nil :inverse-video nil :overline nil
                          :background ,bg :foreground ,yellow
                          :inherit t))))
   `(ace-jump-face-background
     ((,class (:foreground ,bg+3))))

   `(avy-background-face
     ((,class (:foreground ,bg+3))))
   `(avy-lead-face
     ((,class (:underline nil :box nil
                          :strike-through nil :inverse-video nil :overline nil
                          :background ,bg :foreground ,yellow
                          :inherit t))))
   `(avy-lead-face-0
     ((,class (:inherit avy-lead-face))))

   ;; Twitter
   `(twittering-uri-face
     ((,class (:inherit link))))
   `(twittering-username-face           ;TODO
     ((,class (,@string))))

   ;; My own custom faces
   `(ublt-twitter-meta-face
     ((,class (:height 0.8 ,@shadowed))))
   `(ublt-twitter-meta-location
     ((,class (:height 0.8 ,@spectral))))
   `(ublt-twitter-meta-reply
     ((,class (:height 0.8 :foreground ,blue-d))))
   `(ublt-twitter-meta-retweet
     ((,class (:height 0.8 :foreground ,blue))))
   `(ublt/flycheck-message-face         ;TODO
     ((,class (,@vw ,@commitment))))
   `(eproject-ido-imenu-file-path
     ((,class (,@shadowed))))
   `(ublt/emms-mode-line-face
     ((,class (:height 1.0))))
   `(ublt/mode-line-major-mode
     ((,class (:bold t))))
   `(ublt/evil-emacs-tag
     ((,class (,@fw ,@error-hl :foreground ,radio :weight bold))))
   `(ublt/evil-motion-tag
     ((,class (,@fw ,@exception-hl :foreground ,blue-d :weight bold))))
   `(ublt/evil-normal-tag
     ((,class (,@fw :foreground ,blue-d :weight bold))))
   `(ublt/evil-insert-tag
     ((,class (,@fw ,@error-hl :foreground ,blue-l :weight bold))))
   `(ublt/evil-visual-tag
     ((,class (,@fw ,@special-hl :foreground ,blush :weight bold))))

   )
  (custom-theme-set-variables
   'ublt-dark

   `(hl-paren-colors '("#00FF00"
                       "#00DD00"
                       "#00BB00"
                       "#009900"
                       "#007700"
                       "#005500"))
   ))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'ublt-dark)

;;; NTA TODO: Consider these (from http://designmodo.github.com/Flat-UI/)
'("#1abc9c" "Turquoise"
  "#16a085" "Green sea"
  "#2ecc71" "Emerland"
  "#27ae60" "Nephritis"
  "#3498db" "Peter river"
  "#2980b9" "Belize hole"
  "#9b59b6" "Amethyst"
  "#8e44ad" "Wisteria"
  "#34495e" "Wet asphalt"
  "#2c3e50" "Midnight blu"
  "#f1c40f" "Sun flower"
  "#f39c12" "Orange"
  "#e67e22" "Carrot"
  "#d35400" "Pumpkin"
  "#e74c3c" "Alizarin"
  "#c0392b" "Pomegranate"
  "#ecf0f1" "Clouds"
  "#bdc3c7" "Silver"
  "#95a5a6" "Concrete"
  "#7f8c8d" "Asbestos")
