;;; vc-dired.el --- Execute some vc commands in the dired-mode buffer   -*- lexical-binding: t; -*-

;; Copyright (C) 2021  nilninull

;; Author: nilninull <nilninull@gmail.com>
;; Keywords: files

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Execute some vc commands in the dired-mode buffer
;; You can use below commands to the under cursor file or marked files.

;; setup example

;; (with-eval-after-load "vc-hooks"
;;   (autoload 'vc-dired-do-register "vc-dired" nil t)
;;   (autoload 'vc-dired-do-delete "vc-dired" nil t)
;;   (autoload 'vc-dired-do-revert "vc-dired" nil t)
;;   (define-key vc-prefix-map "R" 'vc-dired-do-register)
;;   (define-key vc-prefix-map "X" 'vc-dired-do-delete)
;;   (define-key vc-prefix-map "U" 'vc-dired-do-revert))

;;; Code:
(require 'vc)

(defmacro vc-dired-define-cmd (name &rest body)
  ""
  `(defun ,(intern (format "vc-dired-do-%s" name)) ()
     "This function defined by `vc-dired-define-cmd' macro."
     (interactive)
     (if (derived-mode-p 'dired-mode)
	 (dolist (file (dired-get-marked-files))
	   ,@body)
       (error "Please run this command in dired-mode buffer"))))

(vc-dired-define-cmd register
		     (cond ((vc-git-registered file)
			    (vc-git-register (list file)))
			   ((vc-registered file)
			    (message "%s is already registered" file))
			   (t
			    (vc-register (list (vc-backend-for-registration file)
					       (list file))))))

(vc-dired-define-cmd delete (vc-delete-file file))

(vc-dired-define-cmd revert (vc-revert-file file))

(provide 'vc-dired)
;;; vc-dired.el ends here
