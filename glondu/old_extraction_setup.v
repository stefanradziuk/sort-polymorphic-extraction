(* Based on code from https://stephane.glondu.net/these/memoire.pdf *)

From Coq Require Import Extraction.

Definition G (A : Type) (x : A) (X : (A -> A) * True) : A * nat :=
  (fst X x, O).

Definition boum : True * nat :=
  G True I ((fun x => x), I).

Extraction "old_extraction_setup.ml" G.
Fail Extraction boum.

Extraction Language Haskell.
Extraction "haskell_extraction.hs" boum.
