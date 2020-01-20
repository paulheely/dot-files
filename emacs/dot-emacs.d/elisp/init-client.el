(bind-keys
 ("s-z" . undo-tree-undo)
 ("A-z" . undo-tree-undo)
 ("s-y" . undo-tree-redo)
 ("A-y" . undo-tree-redo)
 ("s-Z" . undo-tree-redo)
 ("A-Z" . undo-tree-redo)
 ("s-x" . kill-region)
 ("A-x" . kill-region)
 ("s-c" . kill-ring-save)
 ("A-c" . kill-ring-save)
 ("s-v" . yank)
 ("A-v" . yank)

 ("s-a" . mark-whole-buffer)
 ("A-a" . mark-whole-buffer)
 ("s-f" . isearch-forward-regexp)
 ("A-f" . isearch-forward-regexp)

 ("s-s" . save-buffer)
 ("A-s" . save-buffer)
 ("s-+" . text-scale-increase)
 ("A-+" . text-scale-increase)
 ("s-=" . text-scale-increase)
 ("A-=" . text-scale-increase)
 ("s--" . text-scale-decrease)
 ("A--" . text-scale-decrease)
 ("s-_" . text-scale-decrease)
 ("A-_" . text-scale-decrease)
 ("s-l" . goto-line)
 ("A-l" . goto-line)
 ("s-w" . bury-buffer)
 ("A-w" . bury-buffer)
 ("s-M-w" . kill-this-buffer)
 ("A-M-w" . kill-this-buffer)

 ("s-<up>" . beginning-of-buffer)
 ("A-<up>" . beginning-of-buffer)
 ("s-<down>" . end-of-buffer)
 ("A-<down>" . end-of-buffer)
 ("s-<left>" . smarter-move-beginning-of-line)
 ("A-<left>" . smarter-move-beginning-of-line)
 ("s-<right>" . move-end-of-line)
 ("A-<right>" . move-end-of-line)

 ("M-<up>" . backward-page)
 ("M-<down>" . forward-page)
 ("M-<left>" . backward-word)
 ("M-<right>" . forward-word))

(defun ha/text-scale-frame-change (fn)
  (let* ((current-font-name (frame-parameter nil 'font))
         (decomposed-font-name (x-decompose-font-name current-font-name))
         (font-size (string-to-int (aref decomposed-font-name 5))))
    (aset decomposed-font-name 5 (int-to-string (funcall fn font-size)))
    (set-frame-font (x-compose-font-name decomposed-font-name))))

(defun ha/text-scale-frame-increase ()
  (interactive)
  (ha/text-scale-frame-change '1+))

(defun ha/text-scale-frame-decrease ()
  (interactive)
  (ha/text-scale-frame-change '1-))

(bind-keys
 ("s-C-+" . ha/text-scale-frame-increase)
 ("A-C-+" . ha/text-scale-frame-increase)
 ("s-C-=" . ha/text-scale-frame-increase)
 ("A-C-=" . ha/text-scale-frame-increase)
 ("s-C--" . ha/text-scale-frame-decrease)
 ("A-C--" . ha/text-scale-frame-decrease))

(setq confirm-kill-emacs 'yes-or-no-p)

(global-font-lock-mode 1)

(defvar ha/fixed-font-family
  (cond ((x-list-fonts "Hasklig")         "Hasklig")
        ((x-list-fonts "Source Code Pro") "Source Code Pro")
        ((x-list-fonts "Anonymous Pro")   "Anonymous Pro")
        ((x-list-fonts "M+ 1mn")          "M+ 1mn"))
  "My fixed width font based on what is installed, `nil' if not defined.")

(defvar ha/variable-font-tuple
  (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
        ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
        ((x-list-fonts "Verdana")         '(:font "Verdana"))
        ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
        (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro.")))
  "My variable width font available to org-mode files and whatnot.")

(use-package color-theme
  :ensure t
  :init (require 'color-theme)
  :config (use-package color-theme-sanityinc-tomorrow
           :ensure t))

(defun org-src-color-blocks-light ()
  "Colors the block headers and footers to make them stand out more for lighter themes"
  (interactive)
  (custom-set-faces
   '(org-block-begin-line
    ((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF"))))
   '(org-block-background
     ((t (:background "#FFFFEA"))))
   '(org-block
     ((t (:background "#FFFFEA"))))
   '(org-block-end-line
     ((t (:overline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF"))))))

(defun org-src-color-blocks-dark ()
  "Colors the block headers and footers to make them stand out more for dark themes"
  (interactive)
  (custom-set-faces
   '(org-block-begin-line
     ((t (:foreground "#008ED1" :background "#002E41"))))
   '(org-block-background
     ((t (:background "#000000"))))
   '(org-block
     ((t (:background "#000000"))))
   '(org-block-end-line
     ((t (:foreground "#008ED1" :background "#002E41"))))))

(deftheme ha/org-theme "Sub-theme to beautify org mode")

(defun ha/change-theme (theme org-block-style)
  "Changes the color scheme and reset the mode line."
  (funcall theme)
  (funcall org-block-style)

  (let* ((ha/fixed-font-tuple (list :font ha/fixed-font-family))
         ; (ha/varible-font-tuple (list :font ha/variable-font-family))
         (base-font-color     (face-foreground 'default nil 'default))
         (background-color    (face-background 'default nil 'default))
         (primary-color       (face-foreground 'mode-line nil))
         (secondary-color     (face-background 'secondary-selection nil 'region))
         (base-height         (face-attribute 'default :height))
         (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

    (when ha/fixed-font-family
      (set-frame-font ha/fixed-font-family)
      (set-face-attribute 'default nil :font ha/fixed-font-family :height 140)
      (set-face-font 'default ha/fixed-font-family))

    ;; Noticeable?
    ;; (set-face-attribute 'region nil :background "#ffff50" :foreground "black")
    ;; Subtle?
    (set-face-attribute 'region nil :background "#0000bb" :foreground 'unspecified)

    (custom-theme-set-faces 'ha/org-theme
                            `(org-agenda-structure ((t (:inherit default :height 2.0 :underline nil))))
                            `(org-verbatim ((t (:inherit 'fixed-pitched :foreground "#aef"))))
                            `(org-table ((t (:inherit 'fixed-pitched))))
                            `(org-block ((t (:inherit 'fixed-pitched))))
                            `(org-block-background ((t (:inherit 'fixed-pitched))))
                            `(org-block-begin-line ((t (:inherit 'fixed-pitched))))
                            `(org-block-end-line ((t (:inherit 'fixed-pitched))))
                            `(org-level-8 ((t (,@headline ,@ha/variable-font-tuple))))
                            `(org-level-7 ((t (,@headline ,@ha/variable-font-tuple))))
                            `(org-level-6 ((t (,@headline ,@ha/variable-font-tuple))))
                            `(org-level-5 ((t (,@headline ,@ha/variable-font-tuple))))
                            `(org-level-4 ((t (,@headline ,@ha/variable-font-tuple
                                                          :height 1.1))))
                            `(org-level-3 ((t (,@headline ,@ha/variable-font-tuple
                                                          :height 1.1))))
                            `(org-level-2 ((t (,@headline ,@ha/variable-font-tuple
                                                          :height 1.1))))
                            `(org-level-1 ((t (,@headline ,@ha/variable-font-tuple
                                                          :height 2.1))))
                            `(org-document-title ((t (,@headline ,@ha/variable-font-tuple :height 1.5 :underline nil)))))))

(ha/change-theme 'color-theme-sanityinc-tomorrow-night 'org-src-color-blocks-dark)

(custom-set-faces
 '(mode-line           ((t (:background "blue4"   :foreground "gray90"))))
 '(mode-line-inactive  ((t (:background "#404045" :foreground "gray60"))))
 '(mode-line-buffer-id ((t (                      :foreground "gold1"   :weight ultra-bold))))
 '(which-func          ((t (                      :foreground "orange"))))
 '(show-paren-match    ((t (:background "default" :foreground "#afa"    :weight ultra-bold))))
 '(show-paren-mismatch ((t (:background "default" :foreground "#cc6666" :weight ultra-bold)))))

(set-face-attribute 'region nil :background "#00a")

(defun frame-fullscreen ()
  "Set the frame window to cover the full screen."
  (interactive)
  (set-frame-parameter nil 'fullscreen 'fullboth))

(defun set-window-width (&optional width)
  "Sets the size of the current window to a specific width.
If no width is specified, it defaults to ~ 80 characters."
  (interactive "p")
  (save-excursion
    (if (not width)
        (setq width 78))
    (if (> (window-width) width)
        (shrink-window-horizontally (- (window-width) width))
      (enlarge-window-horizontally (- width (window-width))))))

(setq ring-bell-function 'ignore)

(defvar cursor-initial-color (face-attribute 'cursor :background)
    "The initial value of the cursor that will be use when re-showing it.")

(defvar cursor-number-chars-before-hiding 2
   "The number of characters one needs to type before we hide the cursor.")

(defvar cursor-current-number-chars 0)

(defun cursor-hide (&optional arg)
  "Hides cursor by setting the color to the background color.
This only happens after a number of characters have been
typed (defined by the `cursor-number-chars-before-hiding'
variable)."
  (setq cursor-current-number-chars (1+ cursor-current-number-chars))
  (when (> cursor-current-number-chars cursor-number-chars-before-hiding)
    (set-cursor-color (or (background-color-at-point) "#1d1f21"))))

(defun cursor-show ()
  "Shows the cursor. At least, sets it to a particular
color (stored/defined in `cursor-initial-color'. Note: This also
resets the `cursor-current-number-chars' variable, so that it
won't be hid until a number of characters have been typed."
  (setq cursor-current-number-chars 0)
  (set-cursor-color cursor-initial-color))

(advice-add 'self-insert-command :after #'cursor-hide)

(setq my-cursor-timer (run-with-idle-timer 1 t #'cursor-show))

(use-package beacon
  :ensure t
  :defer  t
  :diminish 'beacon-mode
  :init  (beacon-mode +1)
  :config (setq beacon-color cursor-initial-color))

(use-package twittering-mode
  :init
  (setq twittering-tweet-filters '("NPR" "#burritowatch"))

  (defun twittering-filter-tweets ()
    "Call string-match on all new tweets"
    (setq non-matching-statuses '())
    (dolist (status twittering-new-tweets-statuses)
      (setq matched-tweets 0)
      (dolist (pat twittering-tweet-filters)
        (if (string-match pat (cdr (assoc 'text status)))
            (setq matched-tweets (+ 1 matched-tweets))))
      (if (= 0 matched-tweets)
          (setq non-matching-statuses
                (append non-matching-statuses `(,status)))))
    (setq new-statuses non-matching-statuses))

  (add-hook 'twittering-edit-mode-hook 'flyspell-mode)
  (add-hook 'twittering-new-tweets-hook 'twittering-filter-tweets))

(if (eq system-type 'darwin)
    (require 'init-mac)
  (require 'init-linux))

(provide 'init-client)
