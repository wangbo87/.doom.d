;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;;(add-to-list 'exec-path "/usr/local/git/bin")
;;(add-to-list 'exec-path "/home/ICer/.nix-profile/bin")
;;(add-to-list 'exec-path "/etc/profiles/per-user/chris/bin")
;;(add-to-list 'exec-path "/run/current-system/sw/bin")
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")


;; (setq doom-font (font-spec :family "Source Code Pro" :size 14 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "" :size 15))

(setq doom-font (font-spec :family "Source Code Pro" :size 14))
 (setq doom-font "Terminus (TTF):pixelsize=14:antialias=off")
  (setq doom-font "Source Code Pro-14")

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
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;custourm;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(define-key global-map (kbd "<S-down-mouse-1>") 'ignore) ; turn off font dialog
;;(define-key global-map (kbd "<S-mouse-1>") 'mouse-set-point)
;;(put 'mouse-set-point 'CUA 'move)
;;(map! :g "C-s" #'save-buffer)
;;
;;(map! :g "<S-down-mouse-1>" #'ignore)
;;(map! :g "<S-mouse-1>" #'mouse-set-point)
;;(put 'mouse-set-point 'CUA 'move)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;color-rg;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(modify-coding-system-alist 'process "rg" '(utf-8 . chinese-gbk-dos))
;;(custom-set-variables '(helm-ag-base-command "rg --vimgrep --no-heading --smart-case"))
(require 'color-rg)
(global-set-key [f2] 'color-rg-search-symbol-in-project)
(global-set-key (kbd "<f3>") 'consult-line)
(global-set-key (kbd "C-f") 'consult-line)

;; If there is no symbol at the cursor, use the last used words instead.
(setq helm-swoop-pre-input-function
      (lambda ()
        (let (($pre-input (thing-at-point 'symbol)))
          (if (eq (length $pre-input) 0)
              helm-swoop-pattern ;; this variable keeps the last used words
            $pre-input))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun enable-minibuffer-auto-search-at-point()
  ;; 参考https://github.com/seagle0128/.emacs.d/blob/master/lisp/init-ivy.el
  ;; @see https://www.reddit.com/r/emacs/comments/b7g1px/withemacs_execute_commands_like_marty_mcfly/
  ;; 还有个更简单的https://emacs-china.org/t/xxx-thing-at-point/18047，但是不太注意细节
  (defvar my-ivy-fly-commands
    '(query-replace-regexp
      flush-lines keep-lines ivy-read
      swiper swiper-backward swiper-all
      swiper-isearch swiper-isearch-backward
      lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol
      my-project-search ;; call-interactively 'counsel-rg的函数需要加进来
      consult-line consult-ripgrep
      my-consult-ripgrep my-consult-ripgrep-only-current-dir my-consult-ripgrep-or-line
      ))

  (defvar my-ivy-fly-back-commands
    '(self-insert-command
      ivy-forward-char ivy-delete-char delete-forward-char kill-word kill-sexp
      end-of-line mwim-end-of-line mwim-end-of-code-or-line mwim-end-of-line-or-code
      yank ivy-yank-word ivy-yank-char ivy-yank-symbol counsel-yank-pop))

  (defvar-local my-ivy-fly--travel nil)
  (defun my-ivy-fly-back-to-present ()
    (cond ((and (memq last-command my-ivy-fly-commands)
                (equal (this-command-keys-vector) (kbd "M-p")))
           ;; repeat one time to get straight to the first history item
           (setq unread-command-events
                 (append unread-command-events
                         (listify-key-sequence (kbd "M-p")))))
          ((or (memq this-command my-ivy-fly-back-commands)
               (equal (this-command-keys-vector) (kbd "M-n")))
           (unless my-ivy-fly--travel
             (delete-region (point) (point-max))
             (when (memq this-command '(ivy-forward-char
                                        ivy-delete-char delete-forward-char
                                        kill-word kill-sexp
                                        end-of-line mwim-end-of-line
                                        mwim-end-of-code-or-line
                                        mwim-end-of-line-or-code))
               ;; 如果是C-e之类，会重新插入搜索内容，但不再是灰的啦
               (when (functionp 'ivy-cleanup-string)
                 (insert (ivy-cleanup-string ivy-text)))
               (when (featurep 'vertico)
                 (insert (substring-no-properties (or (car-safe vertico--input) ""))))
               (when (memq this-command '(ivy-delete-char
                                          delete-forward-char
                                          kill-word kill-sexp))
                 (beginning-of-line)))
             (setq my-ivy-fly--travel t)))))

  (defvar disable-for-vertico-repeat nil)
  (defun my-ivy-fly-time-travel ()
    (unless disable-for-vertico-repeat
      (when (memq this-command my-ivy-fly-commands)
        (insert (propertize
                 (save-excursion
		   (set-buffer (window-buffer (minibuffer-selected-window)))
                   ;; 参考https://emacs-china.org/t/xxx-thing-at-point/18047，可以搜索region
		   (or (seq-some (lambda (thing) (thing-at-point thing t))
				 '(region symbol)) ;; url sexp
		       "")
                   )
                 'face 'shadow))
i        (add-hook 'pre-command-hook 'my-ivy-fly-back-to-present nil t)
        (beginning-of-line)))
    )

  (add-hook 'minibuffer-setup-hook #'my-ivy-fly-time-travel)
  (add-hook 'minibuffer-exit-hook
            (lambda ()
              (remove-hook 'pre-command-hook 'my-ivy-fly-back-to-present t))))

(enable-minibuffer-auto-search-at-point) ;; consult有个:initial也可以设置，不过搜索其它的话要先删除

;(global-set-key [f3] 'color-rg-search-symbol-in-project)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;awesome-tab;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(use-package awesome-tab
;;  :load-path "~/.emacs.d/elpa/awesome-tab"
;;  :config
;;  (awesome-tab-mode t))
;; sort-tab
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;corfu;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;verilog;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
(require 'verilog-mode)

(setq verilog-tool "vlogan")
(setq verilog-linter "vlogan")
(setq verilog-coverage "vlogan")
(setq verilog-simulator "verdi")
(setq verilog-compiler "vlogan" )
