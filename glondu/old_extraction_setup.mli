
type __ = Obj.t

type nat =
| O
| S of nat

type ('a, 'b) prod =
| Pair of 'a * 'b

val fst : ('a1, 'a2) prod -> 'a1

val g : 'a1 -> ('a1 -> 'a1, __) prod -> ('a1, nat) prod
