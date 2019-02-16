module Data.Profunctor.Yoneda where

import Prelude

import Data.Profunctor (class Profunctor, dimap)
import Data.Profunctor.Choice (class Choice, left, right)
import Data.Profunctor.Closed (class Closed, closed)
import Data.Profunctor.Cochoice (class Cochoice, unleft, unright)
import Data.Profunctor.Costrong (class Costrong, unfirst, unsecond)
import Data.Profunctor.Strong (class Strong, first, second)

newtype Yoneda p a b = Yoneda (forall x y. (x -> a) -> (b -> y) -> p x y)

runYoneda :: forall p a b. Yoneda p a b -> (forall x y. (x -> a) -> (b -> y) -> p x y)
runYoneda (Yoneda p) = p

transformYoneda :: forall p q a b c d. Profunctor q => (p a b -> q c d) -> Yoneda p a b -> Yoneda q c d
transformYoneda f p = Yoneda \l r -> dimap l r (f (runYoneda p identity identity))

instance functorYoneda :: Functor (Yoneda p a) where
  map f p = Yoneda \l r -> runYoneda p l (r <<< f)

instance profunctorYoneda :: Profunctor (Yoneda p) where
  dimap l r p = Yoneda \l' r' -> runYoneda p (l <<< l') (r' <<< r)

instance semigroupoidYoneda :: Semigroupoid p => Semigroupoid (Yoneda p) where
  compose p q = Yoneda \l r -> runYoneda p identity r <<< runYoneda q l identity

instance categoryYoneda :: (Category p, Profunctor p) => Category (Yoneda p) where
  identity = Yoneda \l r -> dimap l r identity

instance strongYoneda :: Strong p => Strong (Yoneda p) where
  first = transformYoneda first
  second = transformYoneda second

instance choiceYoneda :: Choice p => Choice (Yoneda p) where
  left = transformYoneda left
  right = transformYoneda right

instance costrongYoneda :: Costrong p => Costrong (Yoneda p) where
  unfirst = transformYoneda unfirst
  unsecond = transformYoneda unsecond

instance cochoiceYoneda :: Cochoice p => Cochoice (Yoneda p) where
  unleft = transformYoneda unleft
  unright = transformYoneda unright

instance closedYoneda :: Closed p => Closed (Yoneda p) where
  closed = transformYoneda closed