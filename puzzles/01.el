(load-file "./aoc-utils.el")

;; Task 1 solution
(let* ((input (aoc-utils/read-input "../inputs/01.txt" #'string-to-number))
       (result (cl-loop for x being elements in input
                        for y being elements in (cdr input)
                        sum (if (< x y) 1 0))))
  (message "Task 1 result: %s" result))

;; Task 2 solution
(let* ((x-window (make-ring 3))
       (y-window (make-ring 3))
       (input (aoc-utils/read-input "../inputs/01.txt" #'string-to-number))
       (result (cl-loop for x being elements in input
                        for y being elements in (cdr input)
                        do (progn
                             (ring-insert x-window x)
                             (ring-insert y-window y))
                        ;; Only start comparing once both windows are full
                        when (and (= 3 (ring-length x-window))
                                  (= 3 (ring-length y-window)))
                        ;; Sum up each window and compare the result
                        sum (let ((x-win (apply #'+ (ring-elements x-window)))
                                  (y-win (apply #'+ (ring-elements y-window))))
                              (if (< x-win y-win) 1 0)))))
  (message "Task 2 result: %s" result))
