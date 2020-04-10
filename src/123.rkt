;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 123ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 123.
;; -------------
;; The use of if may have surprised you in another way because this intermezzo
;; does not mention this form elsewhere. In short, the intermezzo appears to
;; explain and with a form that has no explanation either. At this point, we
;; are relying on your intuitive understanding of if as a short-hand for cond.
;; Write down a rule that shows how to reformulate
;;
;;    (if exp-test exp-then exp-else)
;;
;; as a cond expression. 
;; -----------------------------------------------------------------------------


#;
(if exp-test exp-then exp-else)

; ==

#;
(cond [exp-test exp-then]
      [else exp-else])


