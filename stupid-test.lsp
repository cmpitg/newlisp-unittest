(load "nl-unittest.lsp")

(context 'MAIN)

(define-test (test+)
  (= 1 1)
  (assert= 1 (+ 0 1))
  (assert= 10 (+ 5 3))
  (append "hello" "world"))

(test+)

(exit)
