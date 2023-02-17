From Coq Require Import Extraction.

Module I_tt.

Definition pair_I_I := pair I I.
Check pair_I_I : True * True : Prop.
(* This is an issue - it breaks OCaml extraction.
 * Need the conjuncts to be in Type/Set instead. *)
Fail Extraction pair_I_I.

Definition pair_I_I_with_tt := pair (pair I tt) I.
Fail Check pair_I_I_with_tt : (True * unit) * True : Prop.
(* Now it's not a Prop and OCaml extraction works *)
Extraction pair_I_I_with_tt.

End I_tt.

Module Shuffle.

(* Shuffling the conjuncts in n-ary products and/or changing the associativity
 * can break/fix OCaml extraction. *)

Variable A : Prop.
Variable B : Prop.
Variable X : Set.

Variable a : A.
Variable b : B.
Variable x : X.

Definition conj_bad : (A * B) * X := pair (pair a b) x.
Definition conj_ok  : A * (B * X) := pair a (pair b x).

Fail Extraction conj_bad.
Extraction conj_ok.

End Shuffle.
