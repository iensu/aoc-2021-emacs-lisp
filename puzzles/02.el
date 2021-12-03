(load-file "./aoc-utils.el")

;; Task 1
(cl-flet ((parse-input (line)
            (pcase-let* ((`(,direction ,value) (split-string line " ")))
              `(,(intern direction) . ,(string-to-number value))))

          (to-offset (direction value)
            (pcase direction
              ('forward `(,value . 0))
              ('down    `(0      . ,value))
              ('up      `(0      . ,(* -1 value)))
              (_        '(0      . 0))))

          (sum-offsets (a b)
            (pcase-let* ((`(,x1 . ,y1)  a)
                         (`(,x2 . ,y2) b))
              `(,(+ x1 x2) . ,(+ y1 y2)))))

  (let* ((input (aoc-utils/read-input "../inputs/02.txt"
                                      #'parse-input))
         (final-position (cl-loop for (direction . value) being elements in input
                                  collect (to-offset direction value) into offsets
                                  finally return (cl-reduce #'sum-offsets offsets))))
    (pcase-let ((`(,x . ,y) final-position))
      (* x y))))


;; Task 2
;;
;; - down X increases your aim by X units.
;; - up X decreases your aim by X units.
;; - forward X does two things:
;;   - It increases your horizontal position by X units.
;;   - It increases your depth by your aim multiplied by X.
(cl-flet ((parse-input (line)
            (pcase-let* ((`(,direction ,value) (split-string line " ")))
              `(,(intern direction) . ,(string-to-number value))))

          (sum-offsets (a b)
            (pcase-let* ((`(,x1 . ,y1)  a)
                         (`(,x2 . ,y2) b))
              `(,(+ x1 x2) . ,(+ y1 y2)))))

  (let* ((input (aoc-utils/read-input "../inputs/02.txt"
                                      #'parse-input))
         (final-position (cl-loop with aim = 0
                                  for (direction . value) being elements in input
                                  if (eq direction 'forward)
                                    collect `(,value . ,(* aim value)) into offsets
                                  else
                                    do (set 'aim (+ aim (if (eq direction 'down)
                                                            value
                                                          (* -1 value))))
                                  finally return (cl-reduce #'sum-offsets offsets))))
    (pcase-let ((`(,x . ,y) final-position))
      (* x y))))
