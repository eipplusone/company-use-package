(require 'company)
(require 'seq)
(require 'package)

(defun company-use-package (command &optional arg &rest ignored)
  "Company backend for packages"
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-use-package))
    (prefix (company-grab-line (rx nonl "use-package " (group (zero-or-more nonl))) 1))
    (candidates (seq-remove (lambda (elt) (not (string-match-p arg elt)))
			    (mapcar (lambda (pkg) (symbol-name (car pkg))) package-archive-contents)))
    (annotation (package-desc-summary (car (assoc-default (intern arg) package-archive-contents))))))

(provide 'company-use-package)
