(** old_extraction_setup.ml and old_extraction.ml concatenated **)

type __ = Obj.t

type nat =
| O
| S of nat

type ('a, 'b) prod =
| Pair of 'a * 'b

(** val fst : ('a1, 'a2) prod -> 'a1 **)

let fst = function
| Pair (x, _) -> x

(** val g : 'a1 -> ('a1 -> 'a1, __) prod -> ('a1, nat) prod **)

let g x x0 =
  Pair ((fst x0 x), O)

let __ = let rec f _ = Obj.repr f in Obj.repr f

(** This segfaults(!) **)
let boum =
  g __ (Obj.magic __)
