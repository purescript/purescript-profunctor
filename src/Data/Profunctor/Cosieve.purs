module Data.Profunctor.Cosieve where

import Prelude

import Data.Identity (Identity(..))
import Data.Newtype (unwrap)
import Data.Profunctor (class Profunctor)
import Data.Profunctor.Costar (Costar)

class (Profunctor p, Functor f) <= Cosieve p f | p -> f where
  cosieve :: forall a b. p a b -> f a -> b

instance cosieveIdentity :: Cosieve (->) Identity where
  cosieve f (Identity d) = f d

instance cosieveCostar :: Functor w => Cosieve (Costar w) w where
  cosieve = unwrap