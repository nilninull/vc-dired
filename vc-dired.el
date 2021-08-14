;;; vc-dired.el --- run vc-command in dired buffer   -*- lexical-binding: t; -*-

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

;; Run vc command in dired buffer
;; You can use below commands to the under cursor file or marked files.

;; setup example

;; (with-eval-after-load "vc"
;;   (require 'vc-dired)
;;   (define-key vc-prefix-map "R" 'vc-dired-do-register)
;;   (define-key vc-prefix-map "X" 'vc-dired-do-delete)
;;   (define-key vc-prefix-map "U" 'vc-dired-do-revert))

;;; Code:

(defmacro vc-dired-define-cmd (name &rest body)
  ""
  `(defun ,(intern (format "vc-dired-do-%s" name)) ()
     "This function defined by `vc-dired-define-cmd' macro."
     (interactive)
     (dolist (file (dired-get-marked-files))
       ,@body)))

(vc-dired-define-cmd register
		     (if (vc-registered file)
			 (message "%s is already registered" file)
		       (let ((backend (vc-backend-for-registration file)))
			 (vc-register (list backend (list file))))))

(vc-dired-define-cmd delete (vc-delete-file file))

(vc-dired-define-cmd revert (vc-revert-file file))

(provide 'vc-dired)
;;; vc-dired.el ends here