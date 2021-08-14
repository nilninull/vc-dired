# vc-dired
Execute some vc commands in the dired-mode buffer

You can use below commands to the under cursor file or marked files.

## Setup example
```emacs
(with-eval-after-load "vc-hooks"
  (autoload 'vc-dired-do-register "vc-dired" nil t)
  (autoload 'vc-dired-do-delete "vc-dired" nil t)
  (autoload 'vc-dired-do-revert "vc-dired" nil t)
  (define-key vc-prefix-map "R" 'vc-dired-do-register)
  (define-key vc-prefix-map "X" 'vc-dired-do-delete)
  (define-key vc-prefix-map "U" 'vc-dired-do-revert))
```
