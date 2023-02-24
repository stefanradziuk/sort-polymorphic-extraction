module Haskell_extraction where

import qualified Prelude

__ :: any
__ = Prelude.error "Logical or arity value used"

data Nat =
   O
 | S Nat

data Prod a b =
   Pair a b

fst :: (Prod a1 a2) -> a1
fst p =
  case p of {
   Pair x _ -> x}

g :: a1 -> (Prod (a1 -> a1) ()) -> Prod a1 Nat
g x x0 =
  Pair (fst x0 x) O

-- This throws an error if evaluated
boum :: Prod () Nat
boum =
  g __ __

