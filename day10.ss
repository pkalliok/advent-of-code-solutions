#!/usr/bin/guile \
-e main --use-srfi=1 -s
!#

(define (rotate n l)
  (let ((len (length l)))
    (take (drop (append l l) (modulo n len)) len)))

(define (twist n l)
  (append (reverse (take l n)) (drop l n)))

(define (tie-knot twist-lengths)
  ((fold-right
     (lambda (twist-length k)
       (lambda (knot knot-offset skip-length)
	 (k (rotate (+ twist-length skip-length)
		    (twist twist-length knot))
	    (+ knot-offset twist-length skip-length)
	    (1+ skip-length))))
     (lambda (knot knot-offset skip-length)
       (rotate (modulo (- knot-offset) (length knot)) knot))
     twist-lengths)
   (iota 256) 0 0))

(define (main args)
  (write (tie-knot (read)))
  (newline))

