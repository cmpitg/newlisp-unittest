;;;
;;; This file is a part of the nl-unittest project, released under
;;; MIT license.
;;;
;;; See the COPYING file for more details.
;;;
;;; Copyright (c) 2011 by Dương "Yang" ヤン Hà Nguyễn <cmpitg@gmail.com>
;;;

;;; This file is not designed to use as a standalone program but in
;;; conjuction with other programs.

;;; need cleaning up!!!!!!!!!!!!
(context 'TermColor)

;;; define some terminal color

(constant '+fg-red+    "\\\\033[1;31m")
(constant '+fg-green+  "\\\\033[32m")

(context 'UnitTest)

(setq *enable-term-color*   nil)        ; wanna use colors in console?
(setq *report-failed*       true)       ; wanna report failed assertions?
(setq *report-passed*       true)       ; wanna report passed assertions?
(setq *continue-after-failure* true)

;;; current test in a test-case, *cur-test* help tracking a test which
;;; contains other test cases
(setq *cur-test* '())

;; (setq *total-assert*  0)                ; current number of assertions
;; (setq *passed-assert* 0)                ; number of passed assertions
;; (setq *failed-assert* 0)                ; number of failed assertions

;;; report result of a failed test
(define (report-failure expression)
  (and *report-failed*
       (println (if *enable-term-color*
                    TermColor:+fg-red+
                    "")
                "--> " expression " FAILED!"))
  nil)

;;; requert result of a passed test
(define (report-pass expression)
  (and *report-passed*
       (println (if *enable-term-color*
                    TermColor:+fg-green+
                    "")
                "--> " expression " passed"))
  true)

(define (assertion? form)
  ;; a symbol is an assertion only it ends with "assert="
  (ends-with (term (first form))
             "assert="))

(define (report-result test-case)
  (let (res (eval test-case))
    (if (assertion? test-case)          ; report only at assertion
        (if res
            (report-pass test-case)
            (report-failure test-case))
        'not-an-assertion)))

(define-macro (check test-case)
  (println)
  (println "Testing " *cur-test*)

  (letn (time-running 0 result-list '())
    ;; calculate result and time at the same time
    (setq time-running
          (time (setq result-list (map report-result test-case))))

    ;; because result-list may contain non-assertion expression, we
    ;; need to filter them out
    (letn ((passed-ass (length (filter (lambda (x) (= true x))
                                       result-list)))
           (failed-ass (length (filter (lambda (x) (= nil x))
                                       result-list)))
           (total-ass (+ passed-ass failed-ass)))

      (println "-> Total assertions: " total-ass)
      (println "   - "
               (if (and (= 0 failed-ass)
                        *enable-term-color*)
                   TermColor:+fg-green+ "")
               passed-ass " pass(es)")
      (println "   - "
               (if (and (< 0 failed-ass)
                        *enable-term-color*)
                   TermColor:+fg-red+ "")
               failed-ass " fail(s)!!!")
      (println "   - Total time: " time-running "ms")
      (println)

      ;; the test case is considered passed only if there's no failure
      (= 0 failed-ass))))

;;;
;;; convenient methods in context 'MAIN
;;;

(context 'MAIN)

;;;
;;; alias for ``=`` for testing clarification
;;;
(define (assert=)
  (apply = (args)))

;;;
;;; what this functions does are
;;;   * setting the current test, tracking if the current test contains other tests
;;;   * evaluating every expression in the current test and return the result
(define-macro (define-test params)
  ;;
  ;; `params`     the function signature
  ;; `test_name`  is the name of the test, equals `(first params)`
  ;; `exps`       is the body of the
  ;;
  (eval (expand '(define signature
                  (let ((UnitTest:*cur-test*
                         (append UnitTest:*cur-test* '(test-name))))
                    (UnitTest:check exps)))
                (list (list 'signature  params)
                      (list 'exps       (args))
                      (list 'test-name  (params 0))))))
