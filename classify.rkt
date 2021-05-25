#lang rosette

(provide (all-defined-out))

; Takes as input a propositional formula and returns
; * 'TAUTOLOGY if every interpretation I satisfies F;
; * 'CONTRADICTION if no interpretation I satisfies F;
; * 'CONTINGENCY if there are two interpretations I and I′ such that I satisfies F and I' does not.
(define (classify F)
  (if (unsat? (solve (assert (equal? F #f))))
      'TAUTOLOGY
      (if (unsat? (solve (assert (equal? F #t))))
          'CONTRADICTION 'CONTINGENCY)))

(define-symbolic* p q r boolean?)

; (p → (q → r)) → (¬r → (¬q → ¬p))
(define f0 (=> (=> p (=> q r)) (=> (! r) (=> (! q) (! p)))))

; (p ∧ q) → (p → q)
(define f1 (=> (&& p q) (=> p q)))

; (p ↔ q) ∧ (q → r) ∧ ¬(¬r → ¬p)
(define f2 (&& (<=> p q) (=> q r) (! (=> (! r) (! q)))))

; (p ^ ¬p)
(define f3 (&& p (! p)))

; (p ^ q)
(define f4 (&& p q))

(classify f0)
(classify f1)
(classify f2)
(classify f3)

(classify f4)