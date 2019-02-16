module Data.Profunctor.Cayley where

import Prelude

import Control.Apply (lift2)
import Data.Newtype (class Newtype, over)
import Data.Profunctor (class Profunctor, dimap)
import Data.Profunctor.Choice (class Choice, left, right)
import Data.Profunctor.Strong (class Strong, first, second)

newtype Cayley f p a b = Cayley (f (p a b))

derive instance newtypeCayley :: Newtype (Cayley f p a b) _

instance profunctorCayley :: (Functor f, Profunctor p) => Profunctor (Cayley f p) where
  dimap f g = over Cayley (map (dimap f g))

instance strongCayley :: (Functor f, Strong p) => Strong (Cayley f p) where
  first = over Cayley (map first)
  second = over Cayley (map second)

instance choiceCayley :: (Functor f, Choice p) => Choice (Cayley f p) where
  left = over Cayley (map left)
  right = over Cayley (map right)

instance semigroupoidCayley :: (Apply f, Semigroupoid p) => Semigroupoid (Cayley f p) where
  compose (Cayley x) (Cayley y) = Cayley (lift2 (<<<) x y)

instance categoryCayley :: (Applicative f, Category p) => Category (Cayley f p) where
  identity = Cayley (pure identity)

hoistCayley :: forall p f g a b. (f ~> g) -> Cayley f p a b -> Cayley g p a b
hoistCayley f (Cayley g) = Cayley (f g)