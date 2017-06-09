module Data.Profunctor.Wrap where

import Prelude

import Data.Newtype (class Newtype)
import Data.Profunctor (class Profunctor, rmap)

-- | Provides a `Functor` over the second argument of a `Profunctor`.
newtype Wrap p a b = Wrap (p a b)

derive instance newtypeWrap :: Newtype (Wrap p a b) _
derive newtype instance eqWrap :: Eq (p a b) => Eq (Wrap p a b)
derive newtype instance ordWrap :: Ord (p a b) => Ord (Wrap p a b)

instance showWrap :: Show (p a b) => Show (Wrap p a b) where
  show (Wrap x) = "(Wrap " <> show x <> ")"

instance functorWrap :: Profunctor p => Functor (Wrap p a) where
  map f (Wrap a) = Wrap (rmap f a)
