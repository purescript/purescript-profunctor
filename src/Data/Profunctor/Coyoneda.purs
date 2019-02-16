module Data.Profunctor.Coyoneda where

import Prelude

import Data.Exists (Exists, mkExists, runExists)
import Data.Profunctor (class Profunctor, dimap, rmap)
import Data.Profunctor.Choice (class Choice, left, right)
import Data.Profunctor.Closed (class Closed, closed)
import Data.Profunctor.Cochoice (class Cochoice, unleft, unright)
import Data.Profunctor.Costrong (class Costrong, unfirst, unsecond)
import Data.Profunctor.Strong (class Strong, first, second)

data Coyoneda1 p a b x y = Coyoneda1 (a -> x) (y -> b) (p x y)

newtype Coyoneda2 p a b x = Coyoneda2 (Exists (Coyoneda1 p a b x))

newtype Coyoneda p a b = Coyoneda (Exists (Coyoneda2 p a b))

coyoneda :: forall p a b x y. (a -> x) -> (y -> b) -> (p x y) -> Coyoneda p a b
coyoneda p a b = Coyoneda (mkExists (Coyoneda2 (mkExists (Coyoneda1 p a b))))

runCoyoneda :: forall p a b r. (forall x y. (a -> x) -> (y -> b) -> (p x y) -> r) -> Coyoneda p a b -> r
runCoyoneda f (Coyoneda e) = runExists (\(Coyoneda2 e1) -> runExists (\(Coyoneda1 a b p) -> f a b p) e1) e

transformCoyoneda :: forall p q a b c d. Profunctor p => (p a b -> q c d) -> Coyoneda p a b -> Coyoneda q c d
transformCoyoneda f p = coyoneda identity identity (f (runCoyoneda dimap p))

instance profunctorCoyoneda :: Profunctor (Coyoneda p) where
  dimap l r = runCoyoneda (\l' r' -> coyoneda (l' <<<  l) (r <<< r'))

instance semigroupoidCoyoneda :: (Profunctor p, Semigroupoid p) => Semigroupoid (Coyoneda p) where
  compose p q = runCoyoneda (\lp rp p' -> runCoyoneda (\lq rq q' -> coyoneda lq rp (p' <<< rmap (lp <<< rq) q')) q) p

instance categoryCoyoneda :: (Category p, Profunctor p) => Category (Coyoneda p) where
  identity = coyoneda identity identity identity

instance strongCoyoneda :: Strong p => Strong (Coyoneda p) where
  first = transformCoyoneda first
  second = transformCoyoneda second

instance choiceCoyoneda :: Choice p => Choice (Coyoneda p) where
  left = transformCoyoneda left
  right = transformCoyoneda right

instance costrongCoyoneda :: Costrong p => Costrong (Coyoneda p) where
  unfirst = transformCoyoneda unfirst
  unsecond = transformCoyoneda unsecond

instance cochoiceCoyoneda :: Cochoice p => Cochoice (Coyoneda p) where
  unleft = transformCoyoneda unleft
  unright = transformCoyoneda unright

instance closedCoyoneda :: Closed p => Closed (Coyoneda p) where
  closed = transformCoyoneda closed