;;; scroll-1.el --- bind j and k to scroll the window up and down

;; Copyright 2005, 2008, 2009, 2010 Kevin Ryde

;; Author: Kevin Ryde <user42@zip.com.au>
;; Version: 4
;; Keywords: convenience
;; URL: http://user42.tuxfamily.org/scroll-1/index.html
;; EmacsWiki: Scrolling

;; scroll-1.el is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; either version 3, or (at your option) any later
;; version.
;;
;; scroll-1.el is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
;; Public License for more details.
;;
;; You can get a copy of the GNU General Public License online at
;; <http://www.gnu.org/licenses/>.
 

;;; Commentary:

;; This spot of code sets up keys j and k to scroll the window up or down
;; one line in chosen major modes.

;;; Emacsen:

;; Designed for Emacs 20 and up, works in XEmacs 21.

;;; Install:

;; Put scroll-1.el in one of your `load-path' directories and add to your
;; .emacs
;;
;;     (autoload 'scroll-1-keybindings "scroll-1" nil t)
;;     (autoload 'scroll-1-view-keybindings "scroll-1" nil t)
;;
;; then the mode hooks where you want it, for example
;;
;;     (add-hook 'Info-mode-hook 'scroll-1-keybinding)
;;     (add-hook 'Man-mode-hook  'scroll-1-keybinding)
;;     (add-hook 'view-mode-hook 'scroll-1-view-keybinding)
;;
;; The autoload cookies below make the functions available and add some
;; `customize' options if you know how to use update-file-autoloads etc.
;; The autoloads end up the same size as the whole file!

;;; History:

;; Version 1 - the first version
;; Version 2 - oops, view-mode-map needs its own thing
;; Version 3 - autoload cookie for scroll-1-view-keybindings too
;; Version 4 - scroll-1-view-keybindings load 'view, so usable anywhere
;;           - force scroll-preserve-screen-position for better across images

;;; Code:

;;;###autoload
(defun scroll-1-down ()
  "Scroll down one line."
  (interactive)
  (let ((scroll-preserve-screen-position t))
    (scroll-down 1)))

;;;###autoload
(defun scroll-1-up ()
  "Scroll up one line."
  (interactive)
  (let ((scroll-preserve-screen-position t))
    (scroll-up 1)))

;;;###autoload
(defun scroll-1-keybindings ()
  "Bind keys j and k to scroll the window up and down by one line.
This is designed for use from a major mode hook.  It binds the
keys in the major mode keymap (per `current-local-map') to
functions `scroll-1-up' and `scroll-1-down'.

These bindings are good for non-editing modes like `Info-mode' or
`man' mode.  You don't want it when j and k should insert those
characters!  See `scroll-1-view-keybindings' for specific
`view-mode' handling.

If you use `customize' then `scroll-1-keybindings' is shown in
some likely mode hooks.  Otherwise the setup in your .emacs is as
simple as for example

    (add-hook 'dictionary-mode-hook 'scroll-1-keybinding)

You can also `M-x scroll-1-keybindings' interactively as a
one-off for some mode (though you'll have to attempt an
`unload-feature' and re-load if you want to undo the change).

j and k are the style of the accursed e-VI-l one, but they're
also handy if you touch-type, and follow the \"less\" program if
that's your pager in the shell.

The scroll-1 home page is
URL `http://user42.tuxfamily.org/scroll-1/index.html'"

  (interactive)
  (define-key (current-local-map) [?j] 'scroll-1-up)
  (define-key (current-local-map) [?k] 'scroll-1-down))

;;;###autoload
(defun scroll-1-view-keybindings ()
  "Bind keys j and k in `view-mode' to scroll up and down by one line.
This is designed for use from `view-mode-hook'.  Unlike the main
`scroll-1-keybindings' it operates explicitly on `view-mode-map'
rather than `current-local-map' since of course `view-mode' is
only a minor mode.

XEmacs 21 `view-mode' already has j/k scroll bindings
\(`view-scroll-lines-up' and `view-scroll-lines-down') so you don't
need `scroll-1-view-keybindings' there."

  (interactive)
  (or (boundp 'view-mode-map)
      (condition-case nil (require 'view)      (error nil))  ;; emacs
      (condition-case nil (require 'view-less) (error nil))) ;; xemacs
  (define-key view-mode-map "j" 'scroll-1-up)
  (define-key view-mode-map "k" 'scroll-1-down))

;;;###autoload
(custom-add-option 'compilation-mode-hook 'scroll-1-keybindings)
;;;###autoload
(custom-add-option 'dictem-mode-hook      'scroll-1-keybindings)
;;;###autoload
(custom-add-option 'dictionary-mode-hook  'scroll-1-keybindings)
;;;###autoload
(custom-add-option 'Info-mode-hook        'scroll-1-keybindings)
;;;###autoload
(custom-add-option 'Man-mode-hook         'scroll-1-keybindings)
;;;###autoload
(custom-add-option 'view-mode-hook        'scroll-1-view-keybindings)
;;;###autoload
(custom-add-option 'w3m-mode-hook         'scroll-1-keybindings)

(provide 'scroll-1)

;;; scroll-1.el ends here
