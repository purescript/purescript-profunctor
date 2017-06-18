module Data.Profunctor.Joker where

import Prelude

import Data.Profunctor (class Profunctor)
import Data.Newtype (class Newtype)

-- | Makes a trivial `Profunctor` for a covariant `Functor`.
newtype Joker f a b = Joker (f b)

derive instance newtypeJoker :: Newtype (Joker f a b) _
derive newtype instance eqJoker :: Eq (f b) => Eq (Joker f a b)
derive newtype instance ordJoker :: Ord (f b) => Ord (Joker f a b)

instance showJoker :: Show (f b) => Show (Joker f a b) where
  show (Joker x) = "(Joker " <> show x <> ")"

instance functorJoker :: Functor f => Functor (Joker f a) where
  map f (Joker a) = Joker (map f a)

instance profunctorJoker :: Functor f => Profunctor (Joker f) where
  dimap f g (Joker a) = Joker (map g a)

hoistJoker :: forall f g a b. (f ~> g) -> Joker f a b -> Joker g a b
hoistJoker f (Joker a) = Joker (f a)
