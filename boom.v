Require Import Extraction.
From Coq Require Import Init.Datatypes.

Module boom.
(* Adapted from S. Glondu, Vers une certification de l’extraction de Coq
 * https://stephane.glondu.net/these/memoire.pdf
 *)

Definition G {A : Type} (x : A) (X : (A -> A) * True) :=
  (fst X x, O).

(* Extracts to Haskell but crashes at runtime *)
Definition boom_true :=
  G I ((fun x => x), I).

Definition boom_unit :=
  G tt ((fun x => x), I).

End boom.

Module sigmas.
(* From https://github.com/coq/coq/issues/10749 *)

(* Erased during extraction  *)
Definition prop_and_prop : { n: True & True } :=
  existT (fun _ : True => True) I I.

(* Extracted: ExistT (__, Tt) *)
Definition prop_and_type : { n: True & unit } :=
  existT (fun _ : True => unit) I tt.

(* Extracted: ExistT (Tt, __) *)
Definition type_and_prop : { n: unit & True } :=
  existT (fun _ : unit => True) tt I.

(* Extracted: ExistT (Tt, Tt) *)
Definition type_and_type : { n: unit & unit } :=
  existT (fun _ : unit => unit) tt tt.

(* all of these are extracted as Pair __ __ *)
Definition pair_unit_unit := (unit, unit).
Definition pair_true_unit := (True, unit).
Definition pair_Type_Type := (Prop, Type).
Definition pair_Prop_Type := (Prop, Type).

End sigmas.

(** Extraction **)

Extraction Language OCaml.
Fail Extraction boom.
(* The informative inductive type prod has a Prop instance
 * in boom.boom_true (or in its mutual block).
 * This happens when a sort-polymorphic singleton inductive type
 * has logical parameters, such as (I,I) : (True * True) : Prop.
 * The Ocaml extraction cannot handle this situation yet.
 * Instead, use a sort-monomorphic type such as (True /\ True)
 * or extract to Haskell.
 *)

Extraction Language Haskell.
Extraction boom.

Extraction Language OCaml.
Fail Extraction sigmas.
(* The informative inductive type sigT has a Prop instance
 * in sigmas.prop_and_prop (or in its mutual block).
 * This happens when a sort-polymorphic singleton inductive type
 * has logical parameters, such as (I,I) : (True * True) : Prop.
 * The Ocaml extraction cannot handle this situation yet.
 * Instead, use a sort-monomorphic type such as (True /\ True)
 * or extract to Haskell.
 *)

Extraction Language Haskell.
Extraction sigmas.

