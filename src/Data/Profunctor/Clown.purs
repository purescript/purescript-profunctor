module Data.Profunctor.Clown where

import Prelude

import Data.Profunctor (class Profunctor)
import Data.Newtype (class Newtype)
import Data.Functor.Contravariant (class Contravariant, cmap)

-- | Makes a trivial `Profunctor` for a `Contravariant` functor.
newtype Clown f a b = Clown (f a)

derive instance newtypeClown :: Newtype (Clown f a b) _
derive newtype instance eqClown :: Eq (f a) => Eq (Clown f a b)
derive newtype instance ordClown :: Ord (f a) => Ord (Clown f a b)

instance showClown :: Show (f a) => Show (Clown f a b) where
  show (Clown x) = "(Clown " <> show x <> ")"

instance functorClown :: Functor (Clown f a) where
  map _ (Clown a) = Clown a

instance profunctorClown :: Contravariant f => Profunctor (Clown f) where
  dimap f g (Clown a) = Clown (cmap f a)

hoistClown :: forall f g a b. (f ~> g) -> Clown f a b -> Clown g a b
hoistClown f (Clown a) = Clown (f a)
