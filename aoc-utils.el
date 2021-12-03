(defun aoc-utils/read-input (file-path &optional transform-fn)
  "Returns the contents of FILE-PATH as a list of lines optionally applying the TRANSFORM-FN to each line."
  (letf ((transform (or transform-fn
                       (lambda (x) x))))
    (with-temp-buffer
      (insert-file-contents file-path)
      (mapcar (lambda (x) (funcall transform x))
              (split-string (buffer-string) "\n" :omit-nulls)))))

(provide 'aoc-utils)
