;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 466ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 466
;; ------------
;; Here is a representation for triangular SOEs:
;;
;;    ; A TM is an [NEList-of Equation]
;;    ; such that the Equations are of decreasing length: 
;;    ;   n + 1, n, n - 1, ..., 2. 
;;    ; interpretation represents a triangular matrix
;;
;; Design the triangulate algorithm:
;;
;;    ; SOE -> TM
;;    ; triangulates the given system of equations 
;;    (define (triangulate M)
;;      '(1 2))
;;
;; Turn the above example into a test and spell out explicit answers for the
;; four questions based on our loose description.
;;
;; Do not yet deal with the termination step of the design recipe. 
;; -----------------------------------------------------------------------------

; A Row is a [List-if Number]
; A Matrix is a [List-if Row]
; constraint all rows in matrix are of the same length

; An SOE is a non-empty Matrix.
; constraint for (list r1 ... rn), (length ri) is (+ n 1)
; interpretation represents a system of linear equations
 
; An Equation is a [List-of Number].
; constraint an Equation contains at least two numbers. 
; interpretation if (list a1 ... an b) is an Equation, 
; a1, ..., an are the left-hand-side variable coefficients 
; and b is the right-hand side
 
; A Solution is a [List-of Number]

; A TM is an [NEList-of Equation]
; such that the Equations are of decreasing length: 
;   n + 1, n, n - 1, ..., 2. 
; interpretation represents a triangular matrix

(define m2
  (list (list 2 2  3 10)
        (list 2 5 12 31)
        (list 4 1 -2 1)))

(define m2-sol
  (list (list 2 2  3 10)
        (list   3  9 21)
        (list      1  2)))

(define m3
  (list (list  3  9   21)
        (list -3 -8  -19)))

(define m3-sol
  (list (list 3  9 21)
        (list    1  2)))

; SOE -> TM
; triangulates the given system of equations

(check-expect (triangulate m2) m2-sol)
(check-expect (triangulate m3) m3-sol)

(define (triangulate M)
  (cond [(<= (length (first M)) 2) M]
        [else (cons (first M) (triangulate (no-leading-const M)))]))

; SOE -> SOE
; subtracts frist eq from all aothers
(define (no-leading-const M)
  (map (λ (e) (subtract (first M) e)) (rest M)))

; Equation Equation -> Equation
; subtracts a multiple of e2 from e1 so e1 has
; 0 in the first position. returns the rest of the list of e2

(check-expect (subtract '(2 3 9) '(4 16 27)) '(10 9))
(check-expect (subtract '(2 3 9) '(-4 16 27)) '(22 45))
(check-expect (subtract '(3 3 6) '(4 24 21)) '(20 13))

(define (subtract e1 e2)
  (local ((define c-e1 (first e1))
          (define c-e2 (first e2))
          (define e-to-subtract (map (λ (c) (* c (/ c-e2 c-e1))) e1))
          (define new-e2 (map - e2 e-to-subtract)))
    (rest new-e2)))

