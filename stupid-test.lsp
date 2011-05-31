(load "nl-unittest.lsp")

(context 'MAIN)

(println)

(define-test (test+)
  (= 1 1)
  (assert= 1 (+ 0 1))
  (assert= 10 (+ 5 3))
  (append "hello" "world"))

;;; (test+)

(define-test (test_one)
  (assert= "Hello" "Hello")
  (assert= 6 (factorial 3))
  (assert= '(1 2 3) (sequence 1 3)))

(define-test (test_two)
  (assert= "Hello" "Heo")
  (assert= 6 (factorial 2))
  (assert= 10 (f)))

(define (factorial n)
  (if (= 0 n) 1
      true (* n (factorial (- n 1)))))

(UnitTest:run-all 'MAIN)

(println)

(exit)
