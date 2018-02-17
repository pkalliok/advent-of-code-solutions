
(define (rotate n l)
  (take (drop (append l l l) n) (length l)))

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

(define input '(70 66 255 2 48 0 54 48 80 141 244 254 160 108 1 41))

(define (main)
  (display (apply * (take (tie-knot input) 2)))
  (newline))

