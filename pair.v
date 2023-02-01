Require Import Extraction.
From Coq Require Import Init.Datatypes.

Module prods.

Definition p_tt_tt := (tt, tt).
Definition p_tt_I  := (tt,  I).
Definition p_I_tt  := (I,  tt).
Definition p_I_I   := (I,   I).

End prods.

(** OCaml extraction **)

Extraction Language OCaml.

Extraction prods.p_tt_tt.
Extraction prods.p_tt_I.
Extraction prods.p_I_tt.

(*

(** val p_tt_tt : (unit0, unit0) prod **)

let p_tt_tt =
  Pair (Tt, Tt)

(** val p_tt_I : (unit0, __) prod **)

let p_tt_I =
  Pair (Tt, __)

(** val p_I_tt : (__, unit0) prod **)

let p_I_tt =
  Pair (__, Tt)

 *)

Fail Extraction prods.p_I_I.
(* The informative inductive type prod has a Prop instance
 * in prods.p_I_I (or in its mutual block).
 * This happens when a sort-polymorphic singleton inductive type
 * has logical parameters, such as (I,I) : (True * True) : Prop.
 * The Ocaml extraction cannot handle this situation yet.
 * Instead, use a sort-monomorphic type such as (True /\ True)
 * or extract to Haskell.
 *)

(** Haskell extraction **)

Extraction Language Haskell.

Extraction prods.p_tt_tt.
Extraction prods.p_tt_I.
Extraction prods.p_I_tt.
Extraction prods.p_I_I.

(*

p_tt_tt :: Prod Unit Unit
p_tt_tt =
  Pair Tt Tt

p_tt_I :: Prod Unit ()
p_tt_I =
  Pair Tt __

p_I_tt :: Prod () Unit
p_I_tt =
  Pair __ Tt

p_I_I :: ()
p_I_I =
  __

*)
