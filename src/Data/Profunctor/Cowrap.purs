module Data.Profunctor.Cowrap where

import Prelude

import Data.Newtype (class Newtype)
import Data.Functor.Contravariant (class Contravariant)
import Data.Profunctor (class Profunctor, lmap)

-- | Provides a `Contravariant` over the first argument of a `Profunctor`.
newtype Cowrap p b a = Cowrap (p a b)

derive instance newtypeCowrap :: Newtype (Cowrap p b a) _
derive newtype instance eqCowrap :: Eq (p a b) => Eq (Cowrap p b a)
derive newtype instance ordCowrap :: Ord (p a b) => Ord (Cowrap p b a)

instance showCowrap :: Show (p a b) => Show (Cowrap p b a) where
  show (Cowrap x) = "(Cowrap " <> show x <> ")"

instance contravariantCowrap :: Profunctor p => Contravariant (Cowrap p b) where
  cmap f (Cowrap a) = Cowrap (lmap f a)
