
(define (step dir coord)
  (let ((x (car coord))
	(y (cdr coord)))
    (cons
      (case dir
	((nw sw) (- x 2))
	((n s) x)
	((ne se) (+ x 2)))
      (case dir
	((n) (- y 2))
	((nw ne) (- y 1))
	((sw se) (+ y 1))
	((s) (+ y 2))))))

(define (path-destination path)
  (fold step '(0 . 0) path))

(define (horizontal-distance p1 p2)
  (abs (- (car p1) (car p2))))

(define (vertical-distance p1 p2)
  (abs (- (cdr p1) (cdr p2))))

(define (additional-vertical-steps hdist vdist)
  (max 0 (- vdist (/ hdist 2))))

(define (hex-manhattan-distance p1 p2)
  (let ((hdist (horizontal-distance p1 p2))
	(vdist (vertical-distance p1 p2)))
    (/ (+ hdist (additional-vertical-steps hdist vdist)) 2)))

(define (dist-from-origin p) (hex-manhattan-distance '(0 . 0) p))

(define (scan f i ls)
  (if (null? ls) '()
    (let ((nextval (f (car ls) i)))
      (cons nextval (scan f nextval (cdr ls))))))

(define (path-coordinates path)
  (scan step '(0 . 0) path))

(define (path-max-distance path)
  (fold max 0 (map dist-from-origin (path-coordinates path))))

(define (solve args)
  (let ((data (read)))
    (write (dist-from-origin (path-destination data)))
    (newline)
    (write (path-max-distance data))
    (newline)))

