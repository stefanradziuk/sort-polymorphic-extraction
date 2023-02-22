From Coq Require Init.Datatypes.
Require Import Extraction.

(* Regular conjunction: *)
Definition conj_I_I := conj I I.
Check conj_I_I  : (True /\ True) : Prop.

(* We try to make it not a Prop (so a Set or a Type)
 * by using product instead but Coq still thinks it's a Prop. *)
Definition pair_I_I := pair I I.
Check pair_I_I  : (True * True)  : Prop.

(* Adding in a non-Prop as one of the conjuncts fixes that: *)
Definition pair_I_tt := pair I tt.
Check pair_I_tt : (True * unit)  : Set.

(* Let's try to extract those to OCaml. *)
Extraction Language OCaml.

(* The regular conjuction gets extracted fully erased: *)
Extraction conj_I_I.
(* let conj_I_I = __ *)

(* Coq refuses to extract the pair of Props: *)
Fail Extraction pair_I_I.
(* Error: The informative inductive type prod has a Prop instance... *)

(* Pair of Prop and non-Prop only has the Prop erased, as expected: *)
Extraction pair_I_tt.
(* let pair_I_tt = Pair (__, Tt) *)


(* How is it different in Haskell? *)
Extraction Language Haskell.

(* Same as before: *)
Extraction conj_I_I.
(* conj_I_I = __ *)

(* However, the pair of Props works in Haskell
 * and looks just like any other Prop would: *)
Extraction pair_I_I.
(* pair_I_I = __ *)

(* Nothing interesting here. *)
Extraction pair_I_tt.
(* pair_I_tt = Pair __ Tt *)


(* If a pair of Props is just a Prop, why is it an error in OCaml
 * and not just handled like any other Prop like in Haskell? *)
Check pair_I_I  : (True * True)  : Prop.

Definition bad_conj {A B : Prop} (conj_A_B : A /\ B) : A * nat
  := (proj1 conj_A_B, 1).

Definition bad_pair {A B : Type} (pair_A_B : A * B) : A * nat
  := (fst pair_A_B, 1).

Definition bad_pair_I_tt := bad_pair pair_I_tt.
Extraction Language OCaml.
Extraction bad_pair_I_tt.

Extraction Language Haskell.
Extraction "examples.hs"
  conj_I_I pair_I_I pair_I_tt
  bad_attempt bad.

Extraction Language OCaml.
Extraction "examples.ml"
  conj_I_I pair_I_tt
  bad_attempt bad.
