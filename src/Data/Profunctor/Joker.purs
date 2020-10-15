module Data.Profunctor.Joker where

import Prelude

import Data.Either (Either(..))
import Data.Newtype (class Newtype, un)
import Data.Profunctor (class Profunctor)
import Data.Profunctor.Choice (class Choice)

-- | Makes a trivial `Profunctor` for a covariant `Functor`.
newtype Joker :: forall k1 k2. (k1 -> Type) -> k2 -> k1 -> Type
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

instance clownJoker :: Functor f => Choice (Joker f) where
  left  (Joker f) = Joker $ map Left f
  right (Joker f) = Joker $ map Right f

instance applyJoker :: Apply f => Apply (Joker f a) where
  apply (Joker f) (Joker g) = Joker $ apply f g

instance applicativeJoker :: Applicative f => Applicative (Joker f a) where
  pure = Joker <<< pure

instance bindJoker :: Bind f => Bind (Joker f a) where
  bind (Joker ma) amb = Joker $ ma >>= (amb >>> un Joker)

instance monadJoker :: Monad m => Monad (Joker m a)

hoistJoker :: forall f g a b. (f ~> g) -> Joker f a b -> Joker g a b
hoistJoker f (Joker a) = Joker (f a)
