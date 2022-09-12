;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

;; install org-evil
;; this takes a really long time to install... (3s).. weird
(package! org-evil)

;; install multi-line
(package! multi-line)

;; try out the old fci
(package! fill-column-indicator)

;; ag
(package! ag)

;; yaml support
(package! yaml-mode)

;; own static linter for julia
(package! julia-staticlint
  ;; forked and upgraded from https://github.com/dmalyuta/julia-staticlint
  :recipe (:host github :repo "tdalford/julia-staticlint"
           :files ("*.el" "*.jl")))

;; becnhmark starting time
(package! benchmark-init)

;; custom line-breaker for python/julia
(package! break-line
  :recipe (:host github :repo "tdalford/break-line"))

;; julia formatter
;; didn't work
;; (package! julia-formatter :disable t
;;   :recipe (:host github :repo"ki-chi/julia-formatter"))

;; custom forked julia formatter
(package! julia-formatter
  :recipe (:host github :repo "tdalford/julia-formatter"
           :files ("*.el" "*.jl")))

;; wolfram mode again?
(package! wolfram-mode)

;; use autopep-8 on save instead of black on save (keep black for format/buffer
;; if wanted)
(package! py-autopep8)

;; icons for dired migrated from treemacs
;; (package! treemacs-icons-dired)
