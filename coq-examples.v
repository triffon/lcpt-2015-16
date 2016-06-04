Section Example1.
Variable n : nat.
Hypothesis Pos_n : gt n 0.
Check Pos_n.
Check gt.
Check gt 5 3.
Definition one := (S 0).
Definition two := S one.
Definition double m := plus m m.
Check double.
Print double.
End Example1.

Section Example2.
Variables A B C : Prop.
Check A -> B.

Goal A -> A.
intro u.
apply u.
Save.

Goal A -> B -> A.
intros u v.
exact u.
Save.

Goal (A -> B -> C) -> (A -> B) -> A -> C.
intros.
apply H; [ assumption | apply H0; assumption ].
Save.

Goal A /\ B -> B /\ A.
intro.
split.
elim H.
intros.
assumption.
elim H.
intros.
assumption.
Save.

Goal A /\ B -> B /\ A.
intro H.
elim H.
auto.

Goal A /\ B -> B /\ A.
tauto.


Lemma Peirce : ((A -> B) -> A) -> A.
Require Import Classical.
Check NNPP.
intro u.
apply NNPP.
intro v.
apply v.
apply u.
intro w.
absurd A; [ assumption | assumption].
Save.


Lemma Peirce2 : ((A -> B) -> A) -> A.
tauto.

