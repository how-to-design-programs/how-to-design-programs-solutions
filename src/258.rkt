;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 258ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 258
;; ------------
;; Use a local expression to organize the functions for drawing a polygon in
;; figure 73. If a globally defined function is widely useful, do not make it
;; local.
;; 
;;    ; Image Polygon -> Image 
;;    ; adds an image of p to MT
;;    (define (render-polygon img p)
;;      (render-line (connect-dots img p) (first p) (last p)))
;;     
;;    ; Image NELoP -> Image
;;    ; connects the Posns in p in an image
;;    (define (connect-dots img p)
;;      (cond
;;        [(empty? (rest p)) MT]
;;        [else (render-line (connect-dots img (rest p))
;;                           (first p)
;;                           (second p))]))
;;     
;;    ; Image Posn Posn -> Image 
;;    ; draws a red line from Posn p to Posn q into im
;;    (define (render-line im p q)
;;      (scene+line
;;        im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))
;;     
;;    ; Polygon -> Posn
;;    ; extracts the last item from p
;;    (define (last p)
;;      (cond
;;        [(empty? (rest (rest (rest p)))) (third p)]
;;        [else (last (rest p))]))
;;    
;;    ; Figure 73: Drawing a polygon
;; 
;; -----------------------------------------------------------------------------

(require 2htdp/image)

(define MT (empty-scene 50 50))


; A Polygon is one of:
; – (list Posn Posn Posn)
; – (cons Posn Polygon)


(define triangle-p
  (list
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 30 20)))
 

(define square-p
  (list
    (make-posn 10 10)
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 10 20)))


(check-expect
 (render-polygon MT triangle-p)
 (scene+line
  (scene+line
   (scene+line MT 20 10 20 20 "red")
   20 20 30 20 "red")
  30 20 20 10 "red"))

(check-expect
 (render-polygon MT square-p)
 (scene+line
  (scene+line
   (scene+line
    (scene+line MT 10 10 20 10 "red")
    20 10 20 20 "red")
   20 20 10 20 "red")
  10 20 10 10 "red"))


; ----------


; Image Polygon -> Image 
; adds an image of p to img
(define (render-polygon img p)
  (local (; Image Polygon -> Image 
          ; renders the polygon p on img
          (define (render-polygon-in p)
            (render-line (connect-dots img p) (first p) (last-poly p)))
 
          ; Image NELoP -> Image
          ; connects the Posns in p in an image
          (define (connect-dots img p)
            (cond
              [(empty? (rest p)) MT]
              [else (render-line (connect-dots img (rest p))
                                 (first p)
                                 (second p))]))
 
          ; Image Posn Posn -> Image 
          ; draws a red line from Posn p to Posn q into im
          (define (render-line im p q)
            (scene+line
             im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))
 
          ; Polygon -> Posn
          ; extracts the last item from p
          (define (last-poly p)
            (cond
              [(empty? (rest (rest (rest p)))) (third p)]
              [else (last-poly (rest p))])))

    (render-polygon-in p)))


