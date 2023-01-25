;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; for profiling packages
;; (require 'benchmark-init)
;; (add-hook! 'doom-first-input-hook #'benchmark-init/deactivate)


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Tommy Alford"
      user-mail-address "tdalford1@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; use brighter comments
(setq doom-monokai-classic-brighter-comments t)
;; (setq doom-theme 'doom-monokai-classic) ;;original
(setq doom-theme 'my-doom-monokai-classic) ;;my modified monokai which is better


;; light theme for sunlight
;; (setq doom-one-light-brighter-comments t)
;; (setq doom-theme 'my-doom-one-light) ;;or can use the original doom-one-light
;; (load-theme 'my-doom-one-light t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; mac command modifiers
(setq mac-command-modifier      'meta
      ns-command-modifier       'meta
      mac-option-modifier       'super
      ns-option-modifier        'super
      mac-right-option-modifier 'none
      ns-right-option-modifier  'none)

;; evil don't continue comments
(setq +evil-want-o/O-to-continue-comments nil)

;; helm configs
(after! helm
  (map! :map helm-map "TAB" 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (map! :map helm-map "C-i"   'helm-execute-persistent-action) ; make TAB work in terminal
  (map! :map helm-map "C-z"   'helm-select-action) ; list actions using C-z

  (setq helm-move-to-line-cycle-in-source   nil ; move to end or beginning of source when reaching top or bottom of source.
        helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t) ;; use recent files when searching

  (map! "M-y" 'helm-show-kill-ring) ;; pretty nice when searching for old copied items
  (map! "C-x b" 'helm-mini)
  (setq helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match    t)
  (map! "C-x C-f" 'helm-find-files)
  (when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))
  (setq helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match    t)
  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
  (setq helm-locate-fuzzy-match t)

  (setq helm-mini-default-sources '(helm-source-buffers-list
                                    helm-source-recentf
                                    helm-source-bookmarks
                                    helm-source-buffer-not-found))
  )

  ;; don't include .pngs in recent files, they blow up the size.
(after! recentf
  (add-to-list 'recentf-exclude "\\.png\\'"))

;; Make C-s swiper for file searches
(map! "C-s" 'swiper)

;; make the tab always indent
;; see PR: https://github.com/doomemacs/doomemacs/issues/5932
(setq-default tab-always-indent t)
(map! :m [tab] #'indent-for-tab-command)

;; ibuffer mods -- not sure if last ones are needed or work
(after! ibuffer
  (map! "C-x C-b" 'ibuffer) ;; change from list buffers
  ;; for grouping buffers
  (setq ibuffer-saved-filter-groups
        (quote (("default"
                 ("dired" (mode . dired-mode))
                 ("org" (name . "^.*org$"))
                 ("shell" (or (mode . eshell-mode) (mode . shell-mode)))
                 ("mu4e" (or (mode . mu4e-compose-mode) (name . "\*mu4e\*")))
                 ("programming" (or (mode . prog-mode)))
                 ("emacs" (or
                           (name . "^\\*scratch\\*$")
                           (name . "^\\*Messages\\*$")))
                 )))))

;; still not working... ibuffer-projectile overrides this, too lazy to figure
;; out a full fix.
(add-hook! 'ibuffer-mode-hook
           (lambda ()
             (ibuffer-auto-mode 1)
             (ibuffer-switch-to-saved-filter-groups "default")))


;; Don't show filter groups if there are no buffers in that group
(setq ibuffer-show-empty-filter-groups nil) ; make ibuffer default


;; use avy
(map! "M-s" 'avy-goto-char)

;; old fci mode ;;this does mess up the ellipses and is non-native
;; (define-globalized-minor-mode global-fci-mode fci-mode
;;   (lambda ()
;;     (if (and
;;          (not (string-match "^\*.*\*$" (buffer-name)))
;;          (not (eq major-mode 'dired-mode))
;;          (not (derived-mode-p 'doc-view-mode 'eshell-mode)))
;;         ;; gonna try commenting out
;;         ;; (not (eq major-mode 'org-mode))
;;         (fci-mode 1))))
;; (global-fci-mode 1)

;; specialized display fill column mode
;; but the native mode has gaps in it on my mac
;; (define-globalized-minor-mode global-display-fci-mode display-fill-column-indicator-mode
;;   (lambda ()
;;     (if (and
;;          ;; (not (string-match "^\*.*\*$" (buffer-name)))
;;          (not (eq major-mode 'dired-mode))
;;          (not (derived-mode-p 'doc-view-mode 'eshell-mode)))
;;         ;; gonna try commenting out
;;         ;; (not (eq major-mode 'org-mode))
;;         (display-fill-column-indicator-mode 1))))

(setq-default fill-column 79)
(add-hook! 'prog-mode-hook 'fci-mode)

;; add some initial height and width params
(add-to-list 'default-frame-alist '(width . 98))
(add-to-list 'default-frame-alist '(height . 54))

;; set the evil cursors to change depending on state
;; doom already makes the normal and insert cursors good
(setq ;;evil-insert-state-cursor '((bar . 2) "#AE81FF")
      ;;evil-normal-state-cursor '(box "#AE81FF")
      evil-emacs-state-cursor  '(box "black")
      evil-visual-state-cursor '(box "orange")
      evil-motion-state-cursor '(box "green")
      evil-replace-state-cursor '(box "blue"))

;; map C-a and C-e to original defs
(map!
 :niv "C-a" 'move-beginning-of-line
 :niv "C-e" 'move-end-of-line)

;; redefine c-v to scroll line by line
(map! :n "C-v" 'evil-scroll-line-down)
;; redefine c-; to take the place of tab/c-i in normal made
(map! :n "C-;" 'evil-jump-item)

;; function for darkening org src blocks
(after! (color org)
  (defun org-darken (darken_num)
    ;; darken the org block background
    (setq org-block-background (color-darken-name
                                (face-attribute 'default :background) darken_num))
    (set-face-attribute 'org-block nil :background org-block-background)
    (set-face-attribute 'org-block-begin-line nil :background org-block-background)
    (set-face-attribute 'org-block-end-line nil :background org-block-background)
    ;; make the foreground the monokai comment color--
    ;; maybe a difference choice is better...
    ;; was 75715E #555556
    (set-face-attribute 'org-block-begin-line nil :foreground "#75715E")
  (set-face-attribute 'org-block-end-line nil :foreground "#75715E"))

  (org-darken 3))


(after! org
  ;; preserve org source indentation
  (setq org-src-preserve-indentation t)
  ;; make it so org does not indent subheaders at startup (can still specify
  ;; later)
  ;; actually startup indented i'd say
  ;; (setq org-startup-indented nil)

  ;; make tab
  ;; (setq org-src-tab-acts-natively t)

  ;; org-mode stuff for keyworks-- condense to just 3
  (setq org-todo-keywords
        '((sequence "TODO" "|" "DONE" "WAITING")))

  ;; set the waiting face
  (setq org-todo-keyword-faces
        '(("WAITING" . (:foreground "coral" :weight bold))
          ))

  ;; new binding to display inline images again
  (map! :map org-mode-map "C-c C-b" 'org-redisplay-inline-images)

  ;; try being able to display tramp images in org
  (setq org-display-remote-inline-images 'cache)

  ;; make it so org blocks don't evaluate on export
  (setq org-export-use-babel nil)

  ;; highlight latex stuff in org
  (setq org-highlight-latex-and-related '(native))

  ;; good default image width.
  (setq org-latex-image-default-width "10cm")

  ;; better ellipses
  (setq org-ellipsis "⮐");; ⤵ ⤵ ≫ ⚡⚡⚡  ▼  ⮐ ▼

  ;; org superstar configs
  ;;; Titles and Sections
  ;; hide #+TITLE:
  (setq org-hidden-keywords '(title))
  ;; set org levels
  (set-face-attribute 'org-level-8 nil :inherit 'outline-8)
  ;; Low levels are unimportant => no scaling
  (set-face-attribute 'org-level-7 nil :inherit 'outline-7)
  (set-face-attribute 'org-level-6 nil :inherit 'outline-6)
  (set-face-attribute 'org-level-5 nil :inherit 'outline-5)
  ;; Top ones slight scaling
  (set-face-attribute 'org-level-4 nil :inherit 'outline-4 :height 1.1)
  (set-face-attribute 'org-level-3 nil :inherit 'outline-3 :height 1.15)
  (set-face-attribute 'org-level-2 nil :inherit 'outline-2 :height 1.2)
  (set-face-attribute 'org-level-1 nil :inherit 'outline-1 :height 1.3)
  ;; Make the org title large
  (set-face-attribute 'org-document-title nil
                      :height 2.074
                      :foreground 'unspecified
                      :inherit 'org-level-8)

  ;; some org pdflatex options
  (setq org-latex-src-block-backend 'minted
        org-latex-packages-alist '(("" "minted"))
        org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  (setq org-latex-minted-options
        '(("frame" "lines")
          ("fontsize" "auto")
          ))

  (setq org-latex-verbatim-options
        '(("frame" "lines")
          ("fontsize" "auto")
          ))

  ;; try being able to display tramp images in org
  (setq org-display-remote-inline-images 'cache)

  ;;DONE: add jupyter convert macro
  ;; this could have been made more precisely
  (fset 'convert-jupyter-babel (lambda (&optional arg) "Keyboard
   macro." (interactive "p")
   (kmacro-exec-ring-item
    (quote ([19 66 69 71 73 78 95 83 82 67
                return 79 106 112
                tab escape
                86 106 106 120 86 19 69 78 68 95 83 82 67
                return 110 107 60] 0 "%d")) arg)))
  (map! :map org-mode-map "C-c C-g" 'convert-jupyter-babel)

  ;; show smartparens in org (since they are by default not shown)
  ;; see (lang/org/config.el:1276)
  (remove-hook 'org-mode-hook #'doom-disable-show-paren-mode-h)

  ;;; display/update images in the buffer after I evaluate
  (add-hook! 'org-babel-after-execute-hook :append #'org-redisplay-inline-images)
  (add-hook! 'org-babel-after-execute-hook #'org-redisplay-inline-images)

  )

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h)

  ;; don't clear org babel results with tab (idk why it does this..)
  (remove-hook 'org-tab-first-hook #'+org-clear-babel-results-h))


;; TODO: this is not working and is annoying me... maybe delete bytecode
;; org fork repo some other way
;;DONE: add in guiltydolphin org-evil
;; (use-package! org-evil
;;   :config
;;   ;; same as the actual map now
;;   ;; (map! :map org-list-mode-map
;;   ;;       (:n "O" 'org-evil-list-open-item-or-insert-above)
;;   ;;       (:n "o" 'org-evil-list-open-item-or-insert-below))
;;   ;; (org-evil-mode) ;; already enabled I belive
;;   )

;;DONE: add multi line -- ok this might be too slow
(after! multi-line
  (map! "M-c" 'multi-line)
  )

;; Display the battery
;; kinda useless but my modeline is pretty bare anyways
(display-battery-mode 1)

(after! dired
  ;; dired changes: get the directories not to display first
  (setq dired-listing-switches "-aBhl")

  ;; dired hide long listing by default
  (defun my-dired-mode-setup ()
    "show less information in dired buffers"
    (dired-hide-details-mode 1))
  (add-hook! 'dired-mode-hook 'my-dired-mode-setup)

  ;; toggle hidden files in dired with C-x M-o
  (setq dired-omit-files "^\\...+$")
  (add-hook! 'dired-mode-hook (lambda () (dired-omit-mode 1)))
)

;;DONE: get Mu4e sending to work
(map! "C-x m" 'mu4e)
;; smtp
(with-eval-after-load 'smtpmail
 (setq
   message-send-mail-function   'smtpmail-send-it
   ;; send-mail-function   'smtpmail-send-it
   ;; sendmail-program (executable-find "msmtp")
   smtpmail-stream-type 'starttls
   smtpmail-debug-info t
   smtpmail-debug-verb t
   smtpmail-default-smtp-server "smtp.gmail.com"
   smtpmail-smtp-server         "smtp.gmail.com"
   smtpmail-smtp-service        587
   user-mail-address            "tdalford1@gmail.com"
   use-full-name                "Tommy Alford"
   ;; see post: https://www.reddit.com/r/emacs/comments/l0ra9z/mu4e_sending_email_with_macos_keychain/
   ;; for initial error and command to run in terminal
   auth-sources (quote (macos-keychain-internet macos-keychain-generic))
   ))


;; doom modeline changes
(setq doom-modeline-height 23) ;;25
(setq doom-modeline-enable-word-count nil)
(setq doom-modeline-buffer-modification-icon nil)
(setq doom-modeline-buffer-file-name-style 'truncate-upto-project)

;; make the modeline height be able to decrease
(defun my-doom-modeline--font-height ()
"Calculate the actual char height of the mode-line."
(+ (frame-char-height) 2))

(advice-add #'doom-modeline--font-height
        :override #'my-doom-modeline--font-height)
;; turn on battery, column number mode, size indication mode
(setq column-number-mode t)
(setq size-indication-mode t)
(setq doom-modeline-buffer-encoding nil)
(setq inhibit-compacting-font-caches t)
(setq doom-modeline-indent-info t)
(setq doom-modeline-major-mode-icon t)

;; The limit of the window width.
;; If `window-width' is smaller than the limit, some information won't be
;; displayed. It can be an integer or a float number. `nil' means no limit.
(setq doom-modeline-window-width-limit 85)

;; make all the icons scale factor smaller to fit modeline
(setq all-the-icons-scale-factor 1.0)

;;DONE: ag (don't think there's anything to configure)

;;DONE: get julia linting to work
(use-package! julia-staticlint
  ;; :load-path "~/.emacs.d/patches/julia-staticlint"
  :hook (julia-mode . julia-staticlint-activate)
  :config
  (julia-staticlint-init))

;;DONE: add python shortcut for quick print statement debug
(defun python-debug ()
  (interactive)
  (setq yanked (car kill-ring))
  (end-of-line)
  (newline-and-indent)
  (insert "print('")
  (insert yanked)
  (insert ": %s' % ")
  (insert yanked)
  (insert ")")
  (backward-char 2))

(map! :map python-mode-map :n "SPC d" #'python-debug)

;;DONE: Take away return comment behavior? we'll keep it for now. I think I
;;could remap RET to just newline and not newline and indent to fix this but it
;;is admittedly pretty useful

;;DONE: check org babel header args
;; org default args for python
(setq org-babel-default-header-args:jupyter-python
      '((:async . "yes")
       (:session . "py")
       (:display . "all")
       (:results . "scalar")
       (:exports . "both")))

;; wolfram
(setq org-babel-default-header-args:jupyter-Wolfram-Language
      '((:async . "yes")
       (:exports . "both")
       (:results . "scalar")
       (:session . "wo")
       (:display . "plain")
       ))

;; julia
(setq org-babel-default-header-args:jupyter-julia
      '((:async . "yes")
        (:exports . "both")
        (:results . "scalar")
        (:session . "jl")
        (:display . "all")
        (:display . "text/org image/svg image/jpeg image/png text/plain")
        ))

;; nice blog post on jupyter notebooks in org:
;; https://sqrtminusone.xyz/posts/2021-05-01-org-python/

(after! evil-goggles
  ;; nice seeing when deleting/changing too
  (setq evil-goggles-enable-delete t)
  (setq evil-goggles-enable-change t)
  ;; need to use the diff faces which have actual backgrounds (at least for this
  ;; theme)
  (evil-goggles-use-diff-faces)
  )

;; show line numbers in dired
(add-hook! 'dired-mode-hook #'display-line-numbers-mode)

;; add rainbow delims to all programming modes
(add-hook!'prog-mode-hook 'rainbow-delimiters-mode)


;; Revert Doom-emacs fast index settings back to default
(with-eval-after-load 'mu4e
  (setq
    mu4e-index-cleanup t      ;; do a full cleanup check
    mu4e-index-lazy-check t    ;; consider up-to-date dirs
    ;; mu4d update interval
    mu4e-update-interval 300))

(use-package! break-line
  :config
  (map! :n "M-d" #'break-line-opening-delimiter)
  (map! :n "M-c" #'break-line-arg-sep)
  (map! :n "SPC l" #'break-line))

;; (use-package! julia-formatter
;;   :hook (julia-mode . (lambda() (julia-formatter-server-start))))

;; getting some errors from the not finding some function
;; for now just don't actually enable julia-formatter-mode we'll just call
;; the server when calling julia-formatter-format-buffer, etc
(use-package! julia-formatter
  :after julia-mode
  ;; :hook (julia-mode  #'julia-formatter-mode)
  ;; (recommended) load the server in the background after startup
  ;; think this already loads when we hit julia mode
  ;; (:hook (julia-mode #'julia-formatter--ensure-server))
  :config
  (setq julia-formatter-setup-for-save nil))
  ;;(map! :map julia-mode-map "SPC j" #'julia-formatter-format-buffer))

;; keep recentf files on exit for when i'm using remote stuff
(remove-hook 'kill-emacs-hook #'recentf-cleanup)



;; Make C-c C-c behave like C-u C-c C-c in Python mode
(defun python-send-buffer-auto-main ()
  (interactive)
  (python-shell-send-buffer t))
(map! :map python-mode-map "C-c C-c" #'python-send-buffer-auto-main)

;; use autopep-8 on save instead of black on save (keep black for format/buffer
;; if wanted)
(use-package! py-autopep8
  :hook (python-mode . py-autopep8-mode))

(after! treemacs
  (map! :map treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action)
  (treemacs-follow-mode t)
  (setq treemacs-show-hidden-files nil)
  (setq treemacs-sorting 'mod-time-desc)

  ;; change treemacs colors
  (setq doom-themes-treemacs-theme "doom-colors")

  (setq +treemacs-file-ignore-globs
        '(;; LaTeX
          "*/_minted-*"
          ;; AucTeX
          "*/.auctex-auto"
          "*/_region_.log"
          "*/_region_.tex"
          ;; Python
          "*/__pycache__")))

;; try to get ipython shell readline error to work
(setq python-shell-completion-native-enable nil)

;; customn function for restarting the python console
(defun my-restart-python-console ()
  "Restart python console before evaluate buffer or region to avoid
various uncanny conflicts, like not reloding modules even when
they are changed"
  (interactive)
  ;; if no python buffer exists, just ignore this
  (ignore-errors
    (kill-process "Python")
    (sleep-for 0.05)
    (kill-buffer "*Python*"))
  (run-python)
  (other-window 1)
  (switch-to-buffer "*Python*"))

;; python leader is m
;; map other python commands to this key to
;; just can't use e g i t for letters
(map! :after python
      :map python-mode-map
      :localleader
       "p" #'run-python
       "z" #'python-shell-switch-to-shell
       "l" #'python-shell-send-file
       "r" #'python-shell-send-region
       "s" #'python-shell-send-string
       "c" #'python-send-buffer-auto-main
       "j" #'imenu
       "d" #'python-describe-at-point
       "f" #'python-eldoc-at-point
       "v" #'python-check
       "x" #'python-shell-send-defun
       "a" #'my-restart-python-console
       )

;; quit inferior python mode more easily
(map! :map inferior-python-mode-map :n "q" #'delete-window)

;; make lines wrap in python map
(add-hook! 'inferior-python-mode-hook 'visual-line-mode)

;; map q to kill buffer in imagemagik buffers
(map! :map image-mode-map "q" #'kill-buffer-and-window)

;; debugging for tramp lsp
;; (add-to-list 'tramp-remote-path 'tramp-own-remote-path)

;; add tramp lsp for python.. doesn't work
;; (after! lsp
;;   (lsp-register-client
;;       (make-lsp-client :new-connection (lsp-tramp-connection "pyls")
;;                        :major-modes '(python-mode)
;;                        :remote? t
;;                        )
;;       :server-id 'pyls-remote))

;; change vterm shell to zsh
(after! vterm
  (setq vterm-shell "/bin/zsh"))


;; take this out for now!
;; (use-package! ox-ipynb)
