;;; packages.el --- custom layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Sam Thomas <samthomas@samthomas>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:

;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `custom-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `custom/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `custom/pre-init-PACKAGE' and/or
;;   `custom/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defvar xi-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for `xi-mode'.")

(defvar xi-mode-syntax-table
  (let ((st (make-syntax-table)))
    ;; comments
    (modify-syntax-entry ?/ ". 12b" st)
    (modify-syntax-entry ?* ". 23b" st)
    (modify-syntax-entry ?\n "> b" st)

    ;; strings
    ;; (modify-syntax-entry ?' "\"" st)
    (modify-syntax-entry ?\" "\"" st)
    st)
  "Syntax table for `xi-mode'.")

(setq xi-font-lock-keywords
  (let* (
         (xi-keywords '("use" "if" "while" "else" "return" "length"))
         (xi-types '("int" "bool"))
         (xi-bools '("true" "false"))

         (xi-keywords-regexp (regexp-opt xi-keywords 'words))
         (xi-types-regexp (regexp-opt xi-types 'words))
         (xi-bools-regexp (regexp-opt xi-bools 'word)))

    `(
      (,xi-keywords-regexp . (1 font-lock-keyword-face))
      (,xi-types-regexp . (1 font-lock-type-face))
      (,xi-bools-regexp . (1 font-lock-constant-face))
      )))

 ;;; Indentation

(defvar xi-indent-level 4)

(defun xi-count-back ()
  (let ((count 0)
        (not-top t))
    (save-excursion
      (end-of-line)
      (forward-char -1)
      (if (looking-at "{")
          (forward-char -1))
      (while not-top
        (if (looking-at "}")
            (setq count (- count 1)))
        (if (looking-at "{")
            (setq count (+ count 1)))
        (forward-char -1)
        (if (bobp)
            (setq not-top nil)))
      count)))

(defun xi-print-back ()
  (interactive)
  (message "Back: %s" (xi-count-back)))

(defun xi-indent-line ()
  (interactive)
  (end-of-line)
  (indent-line-to (* xi-indent-level (xi-count-back))))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.xi\\'" . xi-mode))
(add-to-list 'auto-mode-alist '("\\.ixi\\'" . xi-mode))

(define-derived-mode xi-mode prog-mode "Xi Mode"
  "A major mode for editing Xi source files."
  :syntax-table xi-mode-syntax-table
  (setq-local comment-start "// ")
  (setq-local comment-end "")
  (setq-local comment-start-skip "//+\\s-*")
  (setq-local font-lock-defaults
              '((xi-font-lock-keywords)))
  (setq-local indent-line-function 'xi-indent-line))

(provide 'xi-mode)

;;; packages.el ends here
