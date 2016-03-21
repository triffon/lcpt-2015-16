(define (repeated n f x)
    (if (= n 0) x
        (f (repeated (- n 1) f x))))

(define (1+ x) (+ x 1))
(define (sqr x) (* x x))

(define (c n)
  (lambda (f) (lambda (x) (repeated n f x))))

(define c+
  (lambda (m) (lambda (f) (lambda (x) (f ((m f) x))))))

(define (print cn)
  ((cn 1+) 0))